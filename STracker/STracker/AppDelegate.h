//
//  AppDelegate.h
//  STracker
//
//  Created by Ricardo Sousa on 23/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "User.h"
#import "HawkCredentials.h"

// Definition of finish callback.
typedef void (^Finish)(id obj);

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    // Current user information.
    @private
    User *_user;
}

@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, strong) UIStoryboard *storyboard;
// The Hawk credentials, necessary to make protected requests to STracker server.
@property(nonatomic, strong) HawkCredentials *hawkCredentials;

/*!
 @discussion This method returns the most recent user information.
 If the user information are null, prompt to the user one view for 
 Login.
 @param finish The callback for execute code after the Login.
 @return The user information object.
 */
- (void)getUser:(Finish) finish;

/*!
 @discussion This method returns one alert view with one message error (Class method).
 @param msgError The message of the error.
 @return The alert view.
 */
+ (UIAlertView *)getAlertViewForErrors:(NSString *) msgError;

@end