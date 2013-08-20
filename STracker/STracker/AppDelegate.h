//
//  AppDelegate.h
//  STracker
//
//  Created by Ricardo Sousa on 8/17/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "User.h"
#import "HawkCredentials.h"
#import "OfflineUserInfoController.h"

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

@property(nonatomic, strong, readonly) OfflineUserInfoController *dbController;

// Core Data logic.
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
//

/*!
 @discussion This method returns the most recent user information.
 If the user information are null, prompt to the user one view for
 Login. If don't have internet connectivity, tries to get user from 
 DB.
 @param finish The callback for execute code after the Login.
 */
- (void)getUpdatedUser:(Finish) finish;

/*!
 @discussion This method returns the user information that 
 it's in memory. Attention: this method may return out of date 
 user's information. So the caller have the responsibility to 
 know when want the information updated or not, if want the most 
 updated information, may call the method above.
 If the user is nil, performs a Login action.
 @param finish The callback for execute code after the Login.
 */
- (void)getUser:(Finish) finish;

/*!
 @discussion This method returns one alert view with one message error (Class method).
 @param msgError The message of the error.
 @return The alert view.
 */
+ (UIAlertView *)getAlertViewForErrors:(NSString *) msgError;

@end
