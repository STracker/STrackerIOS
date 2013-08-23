//
//  OfflineUserInfoController.m
//  STracker
//
//  Created by Ricardo Sousa on 8/18/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "OfflineUserInfoController.h"
#import "UserData.h"
#import "AsyncQueue.h"

@implementation OfflineUserInfoController

- (id)initWithContext:(NSManagedObjectContext *)context
{
    if (self = [super init])
        _context = context;
    
    return self;
}

- (void)create:(User *)user
{
    // Verify if allready exists in DB.
    if ([self read] != nil)
        return;
    
    [self parseUser:user];
    
    NSError *error;
    [_context save:&error];
    if (error)
        NSLog(@"error create: %@", error.description);
}

- (void)createAsync:(User *)user
{
    [[AsyncQueue sharedObject] performAsyncOperation:^{
        
        [self create:user];
    }];
}

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
    
    return [self parseUserData:uData];
}

- (void)update:(User *)user
{
    [self remove];
    [self create:user];
}

- (void)updateAsync:(User *)user
{
    [[AsyncQueue sharedObject] performAsyncOperation:^{
        
        [self update:user];
    }];
}

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

#pragma mark - OfflineUserInfoController auxiliary private methods.

/*!
 @discussion Auxiliary method for parse one user to UserData.
 @param user    The user for parser.
 @return The object parsed.
 */
- (UserData *)parseUser:(User *)user
{
    UserData *newData = [NSEntityDescription insertNewObjectForEntityForName:@"UserData" inManagedObjectContext:_context];
    newData.identifier = user.identifier;
    newData.name = user.name;
    newData.email = user.email;
    newData.photoUrl = user.photoUrl;
    newData.friends = user.friends;
    newData.friendRequests = user.friendRequests;
    newData.suggestions = user.suggestions;
    newData.subscriptions = user.subscriptions;
    newData.calendar = user.calendar;
    newData.version = [[NSNumber alloc] initWithInt:user.version];
    
    return newData;
}

/*!
 @discussion Auxiliary method for parse one UserData to user.
 @param user    The UserData for parser.
 @return The object parsed.
 */
- (User *)parseUserData:(UserData *)userData
{
    User *user = [[User alloc] init];
    user.identifier = userData.identifier;
    user.name = userData.name;
    user.email = userData.email;
    user.photoUrl = userData.photoUrl;
    user.friends = userData.friends;
    user.friendRequests = userData.friendRequests;
    user.suggestions = userData.suggestions;
    user.subscriptions = userData.subscriptions;
    user.calendar = userData.calendar;
    user.version = [userData.version intValue];
    
    return user;
}

@end
