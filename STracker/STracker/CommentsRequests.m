//
//  CommentController.m
//  STracker
//
//  Created by Ricardo Sousa on 23/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CommentsRequests.h"
#import "STrackerServerHttpClient.h"
#import "Comment.h"
#import "UserInfoManager.h"
#import "Episode.h"
#import "User.h"

@implementation CommentsRequests

+ (void)getTvShowComments:(NSString *)tvshowId finish:(Finish) finish
{
    NSString *uri = [CommentsRequests constructTvShowUri:tvshowId];
    NSString *version = [[STrackerServerHttpClient sharedClient] tryGetVersionFromtCachedData:uri];
    
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        TvShowComments *comments = [[TvShowComments alloc] initWithDictionary:result];

        // Invoke callback.
        finish(comments);
     
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
        
    } withVersion:version];
}

+ (void)getEpisodeComments:(EpisodeId *)episodeId finish:(Finish) finish
{
    NSString *uri = [CommentsRequests constructEpisodeUri:episodeId];
    NSString *version = [[STrackerServerHttpClient sharedClient] tryGetVersionFromtCachedData:uri];
    
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
    
        EpisodeComments *comments = [[EpisodeComments alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(comments);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
        
    } withVersion:version];
}

+ (void)postTvShowComment:(NSString *)tvshowId comment:(NSString *)comment finish:(Finish)finish
{
    [CommentsRequests postComment:[CommentsRequests constructTvShowUri:tvshowId] comment:comment finish:finish];
}

+ (void)postEpisodeComment:(EpisodeId *)episodeId comment:(NSString *)comment finish:(Finish)finish
{
    [CommentsRequests postComment:[CommentsRequests constructEpisodeUri:episodeId] comment:comment finish:finish];
}

+ (void)deleteComment:(NSString *)uri finish:(Finish)finish
{
    // This request requires authentication.
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.userManager getUser:^(User *user) {
        
        [[STrackerServerHttpClient sharedClient] deleteRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
            
            finish(nil);
            
        } failure:^(AFJSONRequestOperation *operation, NSError *error) {
            
            [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
            
        } andHawkCredentials:[user getHawkCredentials]];
    }];
}

#pragma mark - CommentsController auxiliary private methods.

/*!
 @discussion Auxiliary method for generate the television show comments uri.
 */
+ (NSString *)constructTvShowUri:(NSString *)tvshowId
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerTvShowCommentsURI"];
    uri = [uri stringByReplacingOccurrencesOfString:@"id" withString:tvshowId];
    
    return uri;
}

/*!
 @discussion Auxiliary method for generate the episode comments uri.
 */
+ (NSString *)constructEpisodeUri:(EpisodeId *)episodeId
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerEpisodeCommentsURI"];
    uri = [uri stringByReplacingOccurrencesOfString:@"tvshowId" withString:episodeId.tvshowId];
    uri = [uri stringByReplacingOccurrencesOfString:@"seasonNumber" withString:[NSString stringWithFormat:@"%d", episodeId.seasonNumber]];
    uri = [uri stringByReplacingOccurrencesOfString:@"episodeNumber" withString:[NSString stringWithFormat:@"%d", episodeId.episodeNumber]];
    
    return uri;
}

/*!
 @discussion Auxiliary method for post one user's comment into STracker.
 */
+ (void)postComment:(NSString *)uri comment:(NSString *)comment finish:(Finish) finish
{
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:comment, @"", nil];
    
    // This request requires authentication.
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.userManager getUser:^(User *user) {
        
        [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
            
            finish(nil);
            
        } failure:^(AFJSONRequestOperation *operation, NSError *error) {
            
            [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
            
        } andHawkCredentials:[user getHawkCredentials]];
    }];
}

@end
