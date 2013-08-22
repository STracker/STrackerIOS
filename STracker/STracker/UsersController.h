//
//  UsersController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/26/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "AppDelegate.h"
#import "User.h"
#import "Range.h"
#import "Episode.h"

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
 @param range   The search range.
 @param finish  The finish callback.
 */
+ (void)searchUser:(NSString *)name withRange:(Range *)range finish:(Finish) finish;

/*!
 @discussion Get an particular user.
 @param uri     The resource uri.
 @param finish  The finish callback.
 */
+ (void)getUser:(NSString *)uri finish:(Finish) finish;

/*!
 @discussion Get an the current user information. Normally for updates.
 @param identifier  The current user identifier.
 @param finish      The finish callback.
 @param version     The version of user's information in database.
 */
+ (void)getMe:(NSString *)identifier finish:(Finish) finish withVersion:(NSString *) version;

/*!
 @discussion Send user friend request.
 @param user    The user's information object.
 @param finish  The finish callback.
 */
+ (void)inviteUser:(User *)user finish:(Finish) finish;

/*!
 @discussion Delete user friend.
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
 @discussion Accept one friend request.
 @param userId  The identifier of the user who sends the request.
 @param finish  The finish callback.
 */
+ (void)acceptFriendRequest:(NSString *)userId finish:(Finish) finish;

/*!
 @discussion Reject one friend request.
 @param userId  The identifier of the user who sends the request.
 @param finish  The finish callback.
 */
+ (void)rejectFriendRequest:(NSString *)userId finish:(Finish) finish;

/*!
 @discussion Get current user's friends suggestions.
 @param finish  The finish callback.
 */
+ (void)getFriendsSuggestions:(Finish) finish;

/*!
 @discussion Send one suggestion to one friend.
 @param tvshowId    Television show identifier.
 @param friendId    User's friend identifier.
 @param finish      The finish callback.
 */
+ (void)postSuggestion:(NSString *)tvshowId forFriend:(NSString *)friendId finish:(Finish) finish;

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

/*!
 @discussion Make a request for mark one episode as seen.
 @param episodeId   The id of the episode.
 @param finish      The finish callback.
 */
+ (void)postWatchedEpisode:(EpisodeId *)episodeId finish:(Finish) finish;

/*!
 @discussion Make a request for unmark one episode as seen.
 @param episodeId   The id of the episode.
 @param finish      The finish callback.
 */
+ (void)deleteWatchedEpisode:(EpisodeId *)episodeId finish:(Finish) finish;

/*!
 @discussion Get the current user calendar.
 @param finish  The finish callback.
 */
+ (void)getUserCalendar:(Finish) finish;

@end