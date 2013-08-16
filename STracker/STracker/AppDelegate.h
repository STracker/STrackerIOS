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
 If the user information are null prompt the user one view for 
 Login.
 @param finish The callback for execute code after the Login.
 @return The user information object.
 */
- (void)getUpdatedUser:(Finish) finish;

/*!
 @discussion This method returns the value of the user, can be nil or not.
 The caller should know that the user is not nil.
 */
- (User *)getUser;

/*!
 @discussion Well... sometimes is needed to set user with new 
 information. One example is when user makes a shake gesture in 
 table view with friends for update information , when this happens, 
 its needed to update the user in App with the new friends.
 @param newUser The user object with updated information.
 */
- (void)setUser:(User *) newUser;

/*!
 @discussion This method returns one alert view with one message error.
 @param msgError The message of the error.
 @return The alert view.
 */
- (UIAlertView *)getAlertViewForErrors:(NSString *) msgError;

@end