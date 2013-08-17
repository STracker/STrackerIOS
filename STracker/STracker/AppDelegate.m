//
//  AppDelegate.m
//  STracker
//
//  Created by Ricardo Sousa on 23/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "AppDelegate.h"
#import "FacebookView.h"
#import "UIViewController+KNSemiModal.h"
#import "UsersController.h"

@implementation AppDelegate

@synthesize window, storyboard, hawkCredentials;

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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Set storyboard.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
        storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    else
        storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBAppCall handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [FBSession.activeSession close];
}

// Start third party code...

// Helper method to wrap logic for handling app links.
- (void)handleAppLink:(FBAccessTokenData *)appLinkToken {
    // Initialize a new blank session instance...
    FBSession *appLinkSession = [[FBSession alloc] initWithAppID:nil
                                                     permissions:nil
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

#pragma mark - AppDelegate public methods.

- (void)getUser:(Finish)finish
{
    if (_user != nil)
    {
        // Verify if the user information is updated.
        [UsersController getMe:_user.identifier finish:^(User *user) {
            
            _user = user;
            finish(_user);
        }];
        
        return;
    }
    
    FacebookView *fb = [[FacebookView alloc] initWithCallback:^(id obj) {
       
        [self.window.rootViewController dismissSemiModalView];
        _user = obj;
        
        /* 
         Create looper for getting information from server.
         Needed to be logged for this.
         */
        // [self createLooper];
        
        finish(obj);
    }];
    
    [self.window.rootViewController presentSemiView:fb];
}

#pragma mark - AppDelegate class methods.

+ (UIAlertView *)getAlertViewForErrors:(NSString *)msgError
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msgError delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    
    return alert;
}

#pragma mark - AppDelegate auxiliary private methods.

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
