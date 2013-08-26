//
//  OfflineUserInfoController.m
//  STracker
//
//  Created by Ricardo Sousa on 8/18/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "UserInfoManager.h"
#import "User.h"
#import "UserData.h"
#import "AsyncQueue.h"
#import "UsersRequests.h"
#import "LoginManager.h"
#import "FacebookView.h"
#import "UIViewController+KNSemiModal.h"

@implementation UserInfoManager

- (id)initWithContext:(NSManagedObjectContext *)context
{
    if (self = [super init])
        _context = context;
    
    return self;
}

- (void)getUser:(Finish) finish
{
    // Verify if have in memory.
    if (_user != nil)
    {
        finish(_user);
        return;
    }
    
    // Verify if have in DB.
    User *user = [self read];
    if (user != nil)
    {
        finish(user);
        return;
    }
    
    // Perform the login. fbU is the user that comes from FB Login (only have email, name and id).
    [LoginManager loginWithFacebook:^(User *fbU) {
    
        // Register the user into STracker server.
        [UsersRequests registUser:fbU finish:^(User *newUser) {
            
            // Set memory variable, for fast access.
            _user = newUser;
            
            // Insert in DB.
            [self createAsync:newUser];
            
            finish(_user);
        }];
    }];
}

- (void)updateUser:(User *)user
{
    // Increments version for cache purposes.
    user.version++;
    
    // Set memory variable.
    _user = user;
    
    // Update in DB.
    [self updateAsync:user];
}

- (void)syncUser:(Finish) finish
{
    [UsersRequests getMe:_user finish:^(User *user) {
        
        if (user.version > _user.version)
        {
            // Set memory variable.
            _user = user;
            // Update in DB.
            [self updateAsync:user];
        }
        
        // Invoke callback.
        finish(_user);
    }];
}

- (void)deleteUser
{
    [LoginManager logoutFromFacebook:^(id obj) {
        
        // Set memory variable to nil.
        _user = nil;
        
        [[AsyncQueue sharedObject] performAsyncOperation:^{
            
            [self remove];
        }];
    }];
}

#pragma mark - OfflineUserInfoController auxiliary private methods.

- (void)create:(User *) user
{
    UserData *newData = [NSEntityDescription insertNewObjectForEntityForName:@"UserData" inManagedObjectContext:_context];
    [self parseUser:user toUserData:newData];
    
    NSError *error;
    [_context save:&error];
    if (error)
        NSLog(@"error create: %@", error.description);
}

/*!
 @discussion Async version of create method.
 @user  The user information to store in the BD.
 */
- (void)createAsync:(User *)user
{
    [[AsyncQueue sharedObject] performAsyncOperation:^{
        
        [self create:user];
    }];
}

/*!
 @discussion Read method. Note that method don't receives any identifier,
 because there is only one user in BD, the current user information.
 Note that method can return the user information in memory.
 @return The user information.
 */
- (User *)read
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserData" inManagedObjectContext:_context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [_context executeFetchRequest:fetchRequest error:&error];
    if (error || [fetchedObjects count] == 0)
    {
        NSLog(@"error read: %@", error.description);
        return nil;
    }
    
    UserData *uData = [fetchedObjects objectAtIndex:0]; // Only have one...
    
    // avail for set memory variable to...
    [self parseUserData:uData];
    return _user;
}

/*!
 @discussion Update async method.
 @param user    The new user information.
 */
- (void)updateAsync:(User *)user
{
    [[AsyncQueue sharedObject] performAsyncOperation:^{
        
        [self remove];
        [self create:user];
    }];
}

/*!
 @discussion Remove method.
 */
- (void)remove
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserData" inManagedObjectContext:_context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [_context executeFetchRequest:fetchRequest error:&error];
    if (error || [fetchedObjects count] == 0)
    {
        NSLog(@"error remove: %@", error.description);
        return;
    }
    
    UserData *uData = [fetchedObjects objectAtIndex:0]; // Only have one...
    
    [_context deleteObject:uData];
    
    // Perform action.
    [_context save:&error];
    if (error)
        NSLog(@"error remove: %@", error.description);
}

/*!
 @discussion Auxiliary method for parse one user to UserData.
 @param user    The user for parser.
 @param newData The parsed user.
 */
- (void)parseUser:(User *)user toUserData:(UserData *)newData
{
    newData.identifier = user.identifier;
    newData.name = user.name;
    newData.email = user.email;
    newData.photoUrl = user.photoUrl;
    newData.friends = user.friends;
    newData.friendRequests = user.friendRequests;
    newData.suggestions = user.suggestions;
    newData.subscriptions = user.subscriptions;
    newData.version = [[NSNumber alloc] initWithInt:user.version];
}

/*!
 @discussion Auxiliary method for parse one UserData to _user.
 @param userData    The UserData for parser.
 */
- (void)parseUserData:(UserData *)userData
{
    _user = [[User alloc] init];
    _user.identifier = userData.identifier;
    _user.name = userData.name;
    _user.email = userData.email;
    _user.photoUrl = userData.photoUrl;
    _user.friends = userData.friends;
    _user.friendRequests = userData.friendRequests;
    _user.suggestions = userData.suggestions;
    _user.subscriptions = userData.subscriptions;
    _user.version = [userData.version intValue];
}

@end
