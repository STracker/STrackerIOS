//
//  Ratings.h
//  STracker
//
//  Created by Ricardo Sousa on 7/22/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@class EpisodeId;

/*!
 @discussion Info requests for manage ratings 
 information.
 */
@interface RatingsRequests : NSObject

/*!
 @discussion Get telvision show rating from STracker server.
 @param tvshowId    The identifier of the television show.
 @param finish      The finish callback.
 */
+ (void)getTvShowRating:(NSString *)tvshowId finish:(Finish) finish;

/*!
 @discussion Get episode rating from STracker server.
 @param episodeId   The identifier of the episode.
 @param finish      The finish callback.
 */
+ (void)getEpisodeRating:(EpisodeId *)episodeId finish:(Finish) finish;

/*!
 @discussion Post an television show rating in STracker server.
 @param rating      The user's rating.
 @param tvshowId    The identifier of the television show.
 @param finish      The finish callback.
 */
+ (void)postTvShowRating:(float)rating tvshowId:(NSString *)tvshowId finish:(Finish) finish;

/*!
 @discussion Post an episode rating in STracker server.
 @param rating      The user's rating.
 @param episodeId   The identifier of the episode.
 @param finish      The finish callback.
 */
+ (void)postEpisodeRating:(float)rating episodeId:(EpisodeId *)episodeId finish:(Finish) finish;

@end