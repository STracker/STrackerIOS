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

@implementation AppDelegate

@synthesize window, storyboard, hawkCredentials;

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Facebook SDK * login flow *
    // Attempt to handle URLs to complete any auth (e.g., SSO) flow.
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication fallbackHandler:^(FBAppCall *call) {
        // Facebook SDK * App Linking *
        // For simplicity, this sample will ignore the link if the session is already
        // open but a more advanced app could support features like user switching.
        if (call.accessTokenData) {
            if ([FBSession activeSession].isOpen) {
                NSLog(@"INFO: Ignoring app link because current session is open.");
            }
            else {
                [self handleAppLink:call.accessTokenData];
            }
        }
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Set storyboard.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
        storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    else
        storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    
    // Notifications things.
    [self handleLocalNotifications:application withOptions:launchOptions];
    [self createNotificationsForMessages];
    
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

#pragma mark - AppDelegate public methods.

- (void)loginInFacebook:(Finish)finish
{
    if (_user != nil)
    {
        finish(_user);
        return;
    }
    
    FacebookView *fb = [[FacebookView alloc] initWithCallback:^(id obj) {
       [self.window.rootViewController dismissSemiModalView];
        _user = obj;
        finish(obj);
    }];
    
    [self.window.rootViewController presentSemiView:fb];
}

- (UIAlertView *)getAlertViewForErrors:(NSString *)msgError
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msgError delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    
    return alert;
}

#pragma mark - AppDelegate auxiliary private methods.

- (void)handleLocalNotifications:(UIApplication *)application withOptions:(NSDictionary *)launchOptions
{
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (notification == nil)
        return;
    
    
}

- (void)createNotificationsForMessages
{
    UILocalNotification* notification = [[UILocalNotification alloc] init];
    
    // Its necessary to test if nil, because exists one limit of local notifications per application.
    if (notification == nil)
        return;
    
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.fireDate = [NSDate date];
    notification.repeatInterval = NSMinuteCalendarUnit;
    notification.alertBody = @"New message";
    notification.alertAction = @"Show me the message";
    notification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

@end
