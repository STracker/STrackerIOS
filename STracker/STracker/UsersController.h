//
//  UsersController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/26/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "AppDelegate.h"
#import "User.h"

/*!
 @discussion Info controller for manage users 
 information.
 */
@interface UsersController : NSObject

/*!
 @discussion Post an user in STracker server.
 @param user    The user's information object.
 @param finish  The finish callback.
 */
+ (void)registUser:(User *)user finish:(Finish) finish;

/*!
 @discussion Search for users in server.
 @param name    The name for search.
 @param finish  The finish callback.
 */
+ (void)searchUser:(NSString *)name finish:(Finish) finish;

/*!
 @discussion Get an particular user.
 @param uri     The resource uri.
 @param version The version of the resource, for cache control.
 @param finish  The finish callback.
 */
+ (void)getUser:(NSString *)uri withVersion:(NSString *)version finish:(Finish) finish;

/*!
 @discussion Get an the current user information. Normally for updates.
 @param identifier  The current user identifier.
 @param version     The version of the resource, for cache control.
 @param finish      The finish callback.
 */
+ (void)getMe:(NSString *)identifier withVersion:(NSString *)version finish:(Finish) finish;

/*!
 @discussion Send user friend request.
 @param user    The user's information object.
 @param finish  The finish callback.
 */
+ (void)inviteUser:(User *)user finish:(Finish) finish;

/*!
 @discussion Delete user friend request.
 @param friendId    The user's friend identifier.
 @param finish      The finish callback.
 */
+ (void)deleteFriend:(NSString *)friendId finish:(Finish) finish;

/*!
 @discussion Get current user's friends.
 @param finish  The finish callback.
 */
+ (void)getFriends:(Finish) finish;

/*!
 @discussion Get current user's friends requests.
 @param finish  The finish callback.
 */
+ (void)getFriendsRequests:(Finish) finish;

/*!
 @discussion Get current user's friends suggestions.
 @param finish  The finish callback.
 */
+ (void)getFriendsSuggestions:(Finish) finish;

/*!
 @discussion Get current user's favorites television shows.
 @param finish  The finish callback.
 */
+ (void)getUserSubscriptions:(Finish) finish;

/*!
 @discussion Make a request for put one tv show into user's 
 favorites.
 @param tvshowId    The id of television show.
 @param finish      The finish callback.
 */
+ (void)postSubscription:(NSString *)tvshowId finish:(Finish) finish;

/*!
 @discussion Make a request for delete one tv show into user's
 favorites.
 @param tvshowId    The id of television show.
 @param finish      The finish callback.
 */
+ (void)deleteSubscription:(NSString *)tvshowId finish:(Finish) finish;
@end