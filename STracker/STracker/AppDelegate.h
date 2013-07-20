//
//  AppDelegate.h
//  STracker
//
//  Created by Ricardo Sousa on 23/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Instabug/Instabug.h>
#import "User.h"
#import "HawkCredentials.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    // The current user information.
    User *_user;
    
    // The Hawk credentials, necessary to make protected requests to STracker server.
    HawkCredentials *_hawkCredentials;
}

@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, strong) UIStoryboard *storyboard;

/*!
 @discussion This method returns the user information.
 If the user information are null, return null and prompt to the
 user one view for Login with Facebook account.
 @return The user information object.
 */
- (User *)getUser;

/*!
 @discussion This method set the user information object.
 @param user The user.
 */
- (void)setUser:(User *)user;

/*!
 @discussion This method returns the credentials if they are not null.
 If the credentials are null, return null and prompt to the user one view for
 Login with Facebook account.
 @return The user Hawk credentials.
 */
- (HawkCredentials *)getHawkCredentials;

/*!
 @discussion This method set the Hawk credentials field.
 @param credentials The user Hawk credentials.
 */
- (void)setHawkCredentials:(HawkCredentials *)credentials;

/*!
 @discussion This method returns one alert view with one message error.
 @param msgError The message of the error.
 @return The alert view.
 */
- (UIAlertView *)getAlertViewForErrors:(NSString *)msgError;

@end