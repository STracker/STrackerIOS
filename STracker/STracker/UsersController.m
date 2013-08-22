//
//  UsersController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/26/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "UsersController.h"
#import "STrackerServerHttpClient.h"
#import "Suggestion.h"
#import "Subscription.h"
#import "UserCalendar.h"

@implementation UsersController

+ (void)registUser:(User *)user finish:(Finish)finish
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUsersURI"];
    NSArray *keys = [[NSArray alloc] initWithObjects:@"Name", @"Email", @"Photo", nil];
    NSArray *values = [[NSArray alloc] initWithObjects:user.name, user.email, user.photoUrl, nil];
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    
    [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
        
        [self getMe:user.identifier finish:finish withVersion:nil];
    
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)searchUser:(NSString *)name withRange:(Range *)range finish:(Finish)finish
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUsersURI"];
    
    NSArray *keys = [[NSArray alloc] initWithObjects:@"name", @"start", @"end", nil];
    NSArray *values = [[NSArray alloc] initWithObjects:name, [NSString stringWithFormat:@"%d", range.start], [NSString stringWithFormat:@"%d", range.end], nil];
    NSDictionary *query = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    
    [[STrackerServerHttpClient sharedClient] getRequestWithHawkProtocol:uri query:query success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish([self parseUsersToArray:result]);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
        
    } withVersion:nil];
}

+ (void)getUser:(NSString *)uri finish:(Finish) finish
{
    NSString *version = [[STrackerServerHttpClient sharedClient] tryGeVersionFromtCachedData:uri];
    
    [[STrackerServerHttpClient sharedClient] getRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        User *user = [[User alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(user);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
        
    } withVersion:version];
}

+ (void)getMe:(NSString *)identifier finish:(Finish) finish withVersion:(NSString *) version
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUsersURI"];
    uri = [uri stringByAppendingFormat:@"/%@", identifier];
    
    // if version from database is nil, try get it from local cache data.
    if (version == nil)
        version = [[STrackerServerHttpClient sharedClient] tryGeVersionFromtCachedData:uri];
    
    [[STrackerServerHttpClient sharedClient] getRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        User *me = [[User alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(me);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
        
    } withVersion:version];
}

+ (void)inviteUser:(User *)user finish:(Finish)finish
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserFriendsURI"];
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:user.identifier, @"", nil];
    
    [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish(nil);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)deleteFriend:(NSString *)friendId finish:(Finish)finish
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserFriendsURI"];
    uri = [uri stringByAppendingFormat:@"/%@", friendId];
    
    [[STrackerServerHttpClient sharedClient] deleteRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish(nil);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)getFriends:(Finish)finish
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserFriendsURI"];
    
    [[STrackerServerHttpClient sharedClient] getRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish([self parseUsersToArray:result]);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
        
    } withVersion:nil];
}

+ (void)getFriendsRequests:(Finish)finish
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserFriendRequestsURI"];
    
    [[STrackerServerHttpClient sharedClient] getRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish([self parseUsersToArray:result]);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
    
    } withVersion:nil];
}

+ (void)acceptFriendRequest:(NSString *)userId finish:(Finish)finish
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserFriendRequestsURI"];
    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:userId, @"", nil];
    
    [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish(nil);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)rejectFriendRequest:(NSString *)userId finish:(Finish)finish
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserFriendRequestsURI"];
    uri = [uri stringByAppendingFormat:@"/%@", userId];
   
    
    [[STrackerServerHttpClient sharedClient] deleteRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish(nil);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)getFriendsSuggestions:(Finish)finish
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserFriendsSuggestionsURI"];
    
    [[STrackerServerHttpClient sharedClient] getRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            Suggestion *suggestion = [[Suggestion alloc] initWithDictionary:item];
            [data addObject:suggestion];
        }
        
        // Invoke callback.
        finish(data);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
        
    } withVersion:nil];
}

+ (void)postSuggestion:(NSString *)tvshowId forFriend:(NSString *)friendId finish:(Finish)finish
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserFriendsSuggestionsURI"];
    uri = [uri stringByAppendingFormat:@"/%@", tvshowId];
    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:friendId, @"", nil];
    
    [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish(nil);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)getUserSubscriptions:(Finish) finish;
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserSubscriptionsURI"];
    
    [[STrackerServerHttpClient sharedClient] getRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            Subscription *subscription = [[Subscription alloc] initWithDictionary:item];
            [data addObject:subscription];
        }
        
        // Invoke callback.
        finish(data);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
        
    } withVersion:nil];
}

+ (void)postSubscription:(NSString *)tvshowId finish:(Finish)finish
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserSubscriptionsURI"];
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:tvshowId, @"", nil];
    
    [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish(nil);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)deleteSubscription:(NSString *)tvshowId finish:(Finish)finish
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserSubscriptionsURI"];
    uri = [uri stringByAppendingFormat:@"/%@", tvshowId];
    
    [[STrackerServerHttpClient sharedClient] deleteRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish(nil);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)postWatchedEpisode:(EpisodeId *)episodeId finish:(Finish)finish
{
    [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:[self constructEpisodeUri:episodeId] parameters:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish(nil);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)deleteWatchedEpisode:(EpisodeId *)episodeId finish:(Finish)finish
{
    [[STrackerServerHttpClient sharedClient] deleteRequestWithHawkProtocol:[self constructEpisodeUri:episodeId] query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish(nil);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)getUserCalendar:(Finish)finish
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserCalendarURI"];
    
    [[STrackerServerHttpClient sharedClient] getRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        UserCalendar *calendar = [[UserCalendar alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(calendar);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
        
    } withVersion:nil];
}

#pragma mark - UsersController private auxiliary methods.

/*!
 @discussion Auxiliary method for create an array of users from one dictionary.
 @result    The dictionary that contains the users.
 @return The array of the users synopsis objects.
 */
+ (NSArray *)parseUsersToArray:(id) result
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (NSDictionary *item in result)
    {
        UserSynopsis *synopse = [[UserSynopsis alloc] initWithDictionary:item];
        [data addObject:synopse];
    }
    
    return data;
}

/*!
 @discussion Auxiliary method for generate the uri for post and delete watched episodes requests.
 
 */
+ (NSString *)constructEpisodeUri:(EpisodeId *)episodeId
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerWatchedEpisodeURI"];
    uri = [uri stringByReplacingOccurrencesOfString:@"tvshowId" withString:episodeId.tvshowId];
    uri = [uri stringByReplacingOccurrencesOfString:@"seasonNumber" withString:[NSString stringWithFormat:@"%d", episodeId.seasonNumber]];
    uri = [uri stringByReplacingOccurrencesOfString:@"episodeNumber" withString:[NSString stringWithFormat:@"%d", episodeId.episodeNumber]];
    
    return uri;
}

@end
