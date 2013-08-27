//
//  AppDelegate.h
//  STracker
//
//  Created by Ricardo Sousa on 8/17/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserInfoManager;
@class AutomaticUpdater;

// Definition of finish callback.
typedef void (^Finish)(id obj);

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    @private AutomaticUpdater *updater;
}

@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, strong) UIStoryboard *storyboard;
@property(nonatomic, strong, readonly) UserInfoManager *userManager;

// Core Data logic.
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
//

/*!
 @discussion This method returns one alert view with one message error (Class method).
 @param msgError The message of the error.
 @return The alert view.
 */
+ (UIAlertView *)getAlertViewForErrors:(NSString *) msgError;

@end