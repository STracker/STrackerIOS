//
//  OfflineUserInfoController.h
//  STracker
//
//  Created by Ricardo Sousa on 8/18/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

/*!
 @discussion This class have the CRUD operations for user's persistent data.
 Use Core Data framework.
 @see http://developer.apple.com/library/ios/DOCUMENTATION/Cocoa/Conceptual/CoreData/cdProgrammingGuide.html
 */
@interface OfflineUserInfoController : NSObject
{
    /*
     context for manage the data through Core Data.
     */
    @private
    NSManagedObjectContext *_context;
}

/*!
 @discussion Init method that receives the context.
 @param Context The managed oject context for Core Data.
 @return An instance of OfflineUserInfoController.
 */
- (id)initWithContext:(NSManagedObjectContext *)context;

/*!
 @discussion Create method.
 @user  The user information to store in the BD.
 */
- (void)create:(User *)user;

/*!
 @discussion Async version of create method.
 @user  The user information to store in the BD.
 */
- (void)createAsync:(User *)user;

/*!
 @discussion Read method. Note that method don't receives any identifier, 
 because there is only one user in BD, the current user information. 
 This method also parse the UserData for User object for better use of user's 
 information in the rest of the code in this application. 
 @return The user information.
 */
- (User *)read;

/*!
 @discussion Update method.
 @param user The new information.
 */
- (void)update:(User *)user;

/*!
 @discussion Async version of update method.
 @param user The new information.
 */
- (void)updateAsync:(User *)user;

/*!
 @discussion Delete method. Not used in this application.
 */
- (void)remove;
@end
