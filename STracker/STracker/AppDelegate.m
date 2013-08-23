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
#import "FXReachability.h"

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionChange) name:FXReachabilityStatusDidChangeNotification object:nil];
    
    dbController = [[OfflineUserInfoController alloc] initWithContext:self.managedObjectContext];
    
    // Set user information with local information in DB.
    _user = [dbController read];
    _oldUser = _user;
    
    // Set Hawk credentials.
    [self setHawkCredentials:_user.identifier];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBAppCall handleDidBecomeActive];
    
    /*
     Create looper for getting information from server.
     */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL enabled = [defaults boolForKey:@"update_value"];
    if (!enabled)
    {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    
    [self createLooper];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
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
    if (_user == nil)
    {
        [self loginWithFacebook:finish];
        return;
    }
    
    // Only if have connectivity.
    if ([FXReachability isReachable])
        /*
         The user exists, lets get the version number for make a request
         to server for see if this user is updated.
         */
        [self updateUserInformation:finish];
    else
        finish(_user);
}

- (void)getUser:(Finish) finish
{
    if (_user != nil)
    {
        finish(_user);
        return;
    }
    
    [self loginWithFacebook:finish];
}

- (void)deleteUser
{
    [FBSession.activeSession close];
    hawkCredentials = nil;
    _user = nil;
    [self.dbController remove];
}

- (void)getUpdatedCalendar:(Finish)finish
{
    [UsersController getUserCalendar:^(UserCalendar *calendar) {
        
        _user.calendar = calendar;
        
        // Update in DB.
        [dbController updateAsync:_user];
        
        finish(_user.calendar);
    }];
}

- (void)getCalendar:(Finish)finish
{
    if (_user.calendar != nil)
    {
        finish(_user.calendar);
        return;
    }
    
    [self getUpdatedCalendar:finish];
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention!" message:msgError delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
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
        
        // Save in DB.
        [self.dbController create:user];
        
        // Invoke callback.
        finish(user);
    }];
    
    [self.window.rootViewController presentSemiView:fb];
}

/*!
 @discussion Auxiliary method for update _user and user information in DB.
 */
- (void)updateUserInformation:(Finish) finish
{
    [UsersController getMe:_user.identifier finish:^(User *user) {
        
        if (user.version > _user.version)
        {
            // Set the user information in memory.
            user.calendar = _user.calendar;
            _user = user;
            
            // Update the user information in DB.
            /*
             This update are not async because next to this, can
             make open the user's controller and the information
             to show must be updated.
             */
            [self.dbController updateAsync:_user];
        }
        
        // Invoke the callback.
        finish(_user);
        
    } withVersion:[NSString stringWithFormat:@"%d", _user.version]];
}

/*!
 @discussion Selector method for see changes in connectivity.
 */
- (void)connectionChange
{
    if (![FXReachability isReachable])
    {
        [_timer invalidate];
        _timer = nil;
    }
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        BOOL enabled = [defaults boolForKey:@"update_value"];
        if (enabled)
            [self createLooper];
    }
}

#pragma mark - Looper methods.

/*!
 @discussion Auxiliary method for getting periodically information from
 server, like if exists friends requests for user or suggestions from others
 users.
 */
- (void)createLooper
{
    if (_timer != nil)
        return;
    
    // TODO -> put the seconds in users defaults.
    _timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(looperCall) userInfo:nil repeats:YES];
}

/*!
 @discussion Method that is invoked when is time for getting 
 the user information from server.
 */
- (void)looperCall
{
    if (_user == nil)
        return;
    
    NSLog(@"debug: looperCall");
    
    [self updateUserInformation:^(User *user) {
        
        // Update also calendar to...
        [self getUpdatedCalendar:^(id obj) {
            
            // Nothing todo...
        }];
        
        if (_oldUser.friendRequests.count < user.friendRequests.count)
            [[AppDelegate getAlertViewForErrors:@"New friend request received."] show];
        
        if (_oldUser.suggestions.count < user.suggestions.count)
            [[AppDelegate getAlertViewForErrors:@"New suggestion received."] show];
        
        _oldUser = _user;
    }];
}

@end