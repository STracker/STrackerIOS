//
//  UsersController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/26/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "InfoController.h"
#import "User.h"

/*!
 @discussion Info controller for manage users 
 information.
 */
@interface UsersController : InfoController

/*!
 @discussion Post an user in STracker server.
 @param uri     The request uri.
 @param user    The user's information object.
 @param finish  The finish callback.
 */
- (void)registUser:(NSString *)uri withUser:(User *)user finish:(Finish) finish;

/*!
 @discussion Search for users in server.
 @param uri     The request uri.
 @param name    The name for search.
 @param finish  The finish callback.
 */
- (void)searchUser:(NSString *)uri withName:(NSString *)name finish:(Finish) finish;

@end
