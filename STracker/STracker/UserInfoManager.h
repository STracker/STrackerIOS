//
//  OfflineUserInfoController.h
//  STracker
//
//  Created by Ricardo Sousa on 8/18/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@class User;

/*!
 @discussion This class have the CRUD operations for user's persistent data. 
 Also contains the user information in memory for fast reads.
 Use Core Data framework.
 @see http://developer.apple.com/library/ios/DOCUMENTATION/Cocoa/Conceptual/CoreData/cdProgrammingGuide.html
 */
@interface UserInfoManager : NSObject
{
    /*
     User information in memory, for more fast 
     access.
     */
    @private User *_user;
    
    /*
     context for manage the data through Core Data.
     */
    @private NSManagedObjectContext *_context;
}

/*!
 @discussion Initializes the object.
 @param context The managed context.
 @return an UserInfoController instance.
 */
- (id)initWithContext:(NSManagedObjectContext *) context;

/*!
 @discussion Get the user information, if the user don't 
 exists, performs the FB Login.
 @param finish The finish callback.
 */
- (void)getUser:(Finish) finish;

/*!
 @discussion Update user information.
 @param user The new information.
 */
- (void)updateUser:(User *)user;

/*!
 @discussion Performs the synchronization of the user 
 information with server.
 Attention! The user must be logged in before call this method!
 @param finish  The finish callback.
 */
- (void)syncUser:(Finish) finish;

/*!
 @discussion Deletes all user information.
 */
- (void)deleteUser;

@end
