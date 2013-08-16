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

@implementation UsersController

+ (void)registUser:(NSString *)uri withUser:(User *)user finish:(Finish)finish
{
    NSArray *keys = [[NSArray alloc] initWithObjects:@"Name", @"Email", @"Photo", nil];
    NSArray *values = [[NSArray alloc] initWithObjects:user.name, user.email, user.photoUrl, nil];
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    
    [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
        
        User *me = [[User alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(me);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)searchUser:(NSString *)uri withName:(NSString *)name finish:(Finish)finish
{
    NSDictionary *query = [[NSDictionary alloc] initWithObjectsAndKeys:name, @"name", nil];
    
    [[STrackerServerHttpClient sharedClient] getRequestWithHawkProtocol:uri query:query success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish([self parseUsersToArray:result]);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)getUser:(NSString *)uri finish:(Finish)finish
{
    [[STrackerServerHttpClient sharedClient] getRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        User *user = [[User alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(user);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)getUser:(NSString *)uri finish:(Finish)finish withCacheControl:(NSString *)versionNumber
{
    [[STrackerServerHttpClient sharedClient] getRequestWithHawkProtocolWithoutCacheLocalData:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        User *user = nil;
        
        if (result != nil) 
            user = [[User alloc] initWithDictionary:result];
  
        // Invoke callback.
        finish(user);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
        
    } withCacheControl:versionNumber];
}

+ (void)inviteUser:(NSString *)uri withUser:(User *)user finish:(Finish)finish
{
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:user.identifier, @"", nil];
    
    [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish(nil);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)deleteFriend:(NSString *)uri finish:(Finish)finish
{
    [[STrackerServerHttpClient sharedClient] deleteRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish(nil);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)getFriends:(NSString *)uri finish:(Finish)finish
{
    [[STrackerServerHttpClient sharedClient] getRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish([self parseUsersToArray:result]);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)getFriendsRequests:(NSString *)uri finish:(Finish)finish
{
    [[STrackerServerHttpClient sharedClient] getRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish([self parseUsersToArray:result]);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];    }];
}

+ (void)getFriendsSuggestions:(NSString *)uri finish:(Finish)finish
{
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
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)getUserFavoritesTvShows:(NSString *)uri finish:(Finish)finish
{
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
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)postFavoriteTvShow:(NSString *)uri tvshowId:(NSString *)tvshowId finish:(Finish)finish
{
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:tvshowId, @"", nil];
    
    [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish(nil);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)deleteFavoriteTvShow:(NSString *)uri finish:(Finish)finish
{
    [[STrackerServerHttpClient sharedClient] deleteRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish(nil);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

#pragma mark - UsersController private auxiliary methods.

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

@end
