//
//  AppDelegate.m
//  STracker
//
//  Created by Ricardo Sousa on 8/17/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "AppDelegate.h"
#import "FacebookView.h"
#import "UIViewController+KNSemiModal.h"
#import "UsersController.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

@synthesize storyboard, dbController;

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Start third party code...
    
    // Facebook SDK * login flow *
    // Attempt to handle URLs to complete any auth (e.g., SSO) flow.
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication fallbackHandler:^(FBAppCall *call) {
        // Facebook SDK * App Linking *
        // For simplicity, this sample will ignore the link if the session is already
        // open but a more advanced app could support features like user switching.
        if (call.accessTokenData) {
            if ([FBSession activeSession].isOpen)
                NSLog(@"INFO: Ignoring app link because current session is open.");
            else
                [self handleAppLink:call.accessTokenData];
        }
    }];
    
    // ...end third party code
}

// Start third party code...

// Helper method to wrap logic for handling app links.
- (void)handleAppLink:(FBAccessTokenData *)appLinkToken {
    // Initialize a new blank session instance...
    NSArray *permissions = [NSArray arrayWithObjects:@"email", nil];
    FBSession *appLinkSession = [[FBSession alloc] initWithAppID:nil
                                                     permissions:permissions
                                                 defaultAudience:FBSessionDefaultAudienceNone
                                                 urlSchemeSuffix:nil
                                              tokenCacheStrategy:[FBSessionTokenCachingStrategy nullCacheInstance]];
    
    [FBSession setActiveSession:appLinkSession];
    // ... and open it from the App Link's Token.
    [appLinkSession openFromAccessTokenData:appLinkToken
                          completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                              // Forward any errors to the FBLoginView delegate.
                              if (error) {
                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                                  
                                  [alert show];
                              }
                          }];
}

// ...end third party code

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Set storyboard.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    else
        storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    
    dbController = [[OfflineUserInfoController alloc] initWithContext:self.managedObjectContext];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBAppCall handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [FBSession.activeSession close];
    
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

// Core Data logic.
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"STracker" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"STracker.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - AppDelegate public methods.

- (void)getUpdatedUser:(Finish)finish
{
    // First verify if the user exists in memory.
    if (_user == nil)
    {
        // Verify if exists in DB.
        User *dbUser = [self.dbController read];
        if (dbUser == nil)
        {
            [self loginWithFacebook:finish];
            return;
        }
        
        // Set the user information in memory.
        _user = dbUser;
        
        // Set Hawk credentials.
        [self setHawkCredentials:dbUser.identifier];
    }    
    /*
     The user exists, lets get the version number for make a request
     to server for see if this user is updated.
     */
    [UsersController getMe:_user.identifier finish:^(User *user) {
        
        if (user.version > _user.version)
        {
            // Update the user information in DB.
            /*
             This update are not async because next to this, can 
             make open the user's controller and the information 
             to show must be updated.
             */
            [self.dbController update:user];
            
            // Set the user information in memory.
            _user = user;
        }
        
        // Invoke the callback.
        finish(_user);
        
    } withVersion:[NSString stringWithFormat:@"%d", _user.version]];
}

- (void)getUser:(Finish) finish
{
    if (_user != nil)
    {
        finish(_user);
        return;
    }
    
    // Try get from DB.
    User *dbUser = [self.dbController read];
    if (dbUser != nil)
    {
        _user = dbUser;
        
        // Set Hawk credentials.
        [self setHawkCredentials:dbUser.identifier];
        finish(_user);
        return;
    }

    [self loginWithFacebook:finish];
}

- (void)setHawkCredentials:(NSString *)userId
{
    hawkCredentials = [[HawkCredentials alloc] init];
    hawkCredentials.identifier = userId;
    hawkCredentials.key = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"HawkKey"];
}

- (HawkCredentials *)getHawkCredentials
{
    return hawkCredentials;
}

#pragma mark - AppDelegate class methods.

+ (UIAlertView *)getAlertViewForErrors:(NSString *)msgError
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msgError delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    
    return alert;
}

#pragma mark - AppDelegate auxiliary private methods.

/*!
 @discussion Auxiliary method for make a login with Facebook account.
 @param finish  The finish callback.
 */
- (void)loginWithFacebook:(Finish) finish
{
    FacebookView *fb = [[FacebookView alloc] initWithCallback:^(User *user) {
        
        [self.window.rootViewController dismissSemiModalView];
        _user = user;
        
        /*
         Create looper for getting information from server.
         Needed to be logged for this.
         */
        // [self createLooper];
        
        
        // Save in DB.
        [self.dbController create:user];
        
        // Invoke callback.
        finish(user);
    }];
    
    [self.window.rootViewController presentSemiView:fb];
}

/*!
 @discussion Auxiliary method for getting periodically information from
 server, like if exists friends requests for user or suggestions from others
 users.
 */
- (void)createLooper
{
    /*NSTimer *timer = */[NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(verifyStatus) userInfo:nil repeats:YES];
    
    /*
     Don't fire now, because the request login in facebook returns
     the updated user information.
     */
    // [timer fire];
}

/*!
 @discussion Method that is invoked when is time for getting the information
 from server.
 */
- (void)verifyStatus
{
    /*
     NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserFriendRequestsURI"];
     [UsersController getFriendsRequests:uri finish:^(id obj) {
     
     _user.friendRequests = obj;
     }];
     
     uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserFriendsSuggestionsURI"];
     [UsersController getFriendsSuggestions:uri finish:^(id obj) {
     
     _user.suggestions = obj;
     }];
     */
}

@end