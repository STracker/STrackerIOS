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
#import "OfflineUserInfoController.h"
#import "HawkCredentials.h"

// Definition of finish callback.
typedef void (^Finish)(id obj);

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    // Current user information.
    @private
    User *_user;
    // Necessary for looper.
    @private
    User *_oldUser;
    
    // The Hawk credentials, necessary to make protected requests to STracker server.
    @private
    HawkCredentials *hawkCredentials;
    
    @private
    NSTimer *_timer;
}

@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, strong) UIStoryboard *storyboard;
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
 @param finish The callback.
 */
- (void)getUpdatedUser:(Finish) finish;

/*!
 @discussion This method returns the user information that 
 it's in memory. Attention: this method may return out of date 
 user's information. So the caller have the responsibility to 
 know when want the information updated or not, if want the most 
 updated information, may call the method above.
 If the user is nil, performs a Login action.
 @param finish The callback.
 */
- (void)getUser:(Finish) finish;

/*!
 @discussion Performs the delete of the user information in memmory and BD,
 also close session in FB.
 */
- (void)deleteUser;

/*!
 @discussion Gets the must updated calendar.
 @param finish The callback.
 */
- (void)getUpdatedCalendar:(Finish) finish;

/*!
 @discussion Gets the calendar user. If nil, performs a request to 
 server.
 @param finish The callback.
 */
- (void)getCalendar:(Finish) finish;

/*!
 @discussion This method create and set the hawk credentials.
 @param userId  The current user identifier.
 */
- (void)setHawkCredentials:(NSString *)userId;

/*!
 @discussion This method returns the hawk credentials.
 @return    The user's Hawk credentials.
 */
- (HawkCredentials *)getHawkCredentials;

/*!
 @discussion This method returns one alert view with one message error (Class method).
 @param msgError The message of the error.
 @return The alert view.
 */
+ (UIAlertView *)getAlertViewForErrors:(NSString *) msgError;

@end
