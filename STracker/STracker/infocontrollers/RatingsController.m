//
//  Ratings.m
//  STracker
//
//  Created by Ricardo Sousa on 7/22/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "RatingsController.h"
#import "STrackerServerHttpClient.h"
#import "Rating.h"

@implementation RatingsController

+ (void)getTvShowRating:(NSString *)tvshowId finish:(Finish) finish
{
    [RatingsController getRating:[RatingsController constructTvShowUri:tvshowId] finish:finish];
}

+ (void)getEpisodeRating:(EpisodeId *)episodeId finish:(Finish) finish
{
    [RatingsController getRating:[RatingsController constructEpisodeUri:episodeId] finish:finish];
}

+ (void)postTvShowRating:(float)rating tvshowId:(NSString *)tvshowId finish:(Finish)finish
{
    [RatingsController postRating:[RatingsController constructTvShowUri:tvshowId] withRating:rating finish:finish];
}

+ (void)postEpisodeRating:(float)rating episodeId:(EpisodeId *)episodeId finish:(Finish)finish
{
    [RatingsController postRating:[RatingsController constructEpisodeUri:episodeId] withRating:rating finish:finish];
}

#pragma mark - RatingsController private auxiliary methods.

/*!
 @discussion Auxiliary method for generate the television show comments uri.
 */
+ (NSString *)constructTvShowUri:(NSString *)tvshowId
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerTvShowRatingsURI"];
    uri = [uri stringByReplacingOccurrencesOfString:@"id" withString:tvshowId];
    
    return uri;
}

/*!
 @discussion Auxiliary method for generate the episode comments uri.
 */
+ (NSString *)constructEpisodeUri:(EpisodeId *)episodeId
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerEpisodeRatingsURI"];
    uri = [uri stringByReplacingOccurrencesOfString:@"tvshowId" withString:episodeId.tvshowId];
    uri = [uri stringByReplacingOccurrencesOfString:@"seasonNumber" withString:[NSString stringWithFormat:@"%d", episodeId.seasonNumber]];
    uri = [uri stringByReplacingOccurrencesOfString:@"episodeNumber" withString:[NSString stringWithFormat:@"%d", episodeId.episodeNumber]];
    
    return uri;
}

/*!
 @discussion Auxiliary method for get the rating.
 */
+ (void)getRating:(NSString *)uri finish:(Finish) finish
{
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        Rating *rating = [[Rating alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(rating);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
        
    } withVersion:nil];
}

/*!
 @discussion Auxiliary method for post one rating.
 */
+ (void)postRating:(NSString *)uri withRating:(float)rating finish:(Finish) finish
{
    NSString * ratingStr = [NSString stringWithFormat:@"%d", (int)rating];
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:ratingStr] forKeys:[NSArray arrayWithObject:@""]];
    
    [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish(nil);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
    }];
}

@end
