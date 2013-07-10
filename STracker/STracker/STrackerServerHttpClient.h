//
//  STrackerServerHttpClient.h
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "Genre.h"
#import "TvShow.h"
#import "Episode.h"
#import "User.h"
#import "HawkClient_iOS.h"
#import "Comment.h"

#define TIME_FORMAT @"yyyy-MM-dd HH:mm:ss"

// Define the callbacks.
typedef void (^Success)(AFJSONRequestOperation *operation, id result);
typedef void (^Failure)(AFJSONRequestOperation *operation, NSError *error);

@interface STrackerServerHttpClient : AFHTTPClient
{
    HawkClient_iOS *_hawkClient;
    HawkCredentials *_credentials;
}

// Class method that returns a shared singleton instance.
+ (id)sharedClient;

// Method for set hawk credentials, for using on requests with Hawk protocol.
- (void)setHawkCredentials:(HawkCredentials *)credentials;

// Users operations.
- (void)getUser:(NSString *)userId success:(Success)success failure:(Failure)failure;
- (void)postUser:(User *)user success:(Success)success failure:(Failure)failure;

// Genres operations.
- (void)getGenres:(Success)success failure:(Failure)failure;
- (void)getTvShowsByGenre:(GenreSynopsis *)genre success:(Success)success failure:(Failure) failure;

// Tv shows operations.
- (void)getTvshow:(TvShowSynopse *)tvshow success:(Success)success failure:(Failure) failure;
- (void)getTvshowsByName:(NSString *)name success:(Success)success failure:(Failure) failure;
- (void)getTopRated:(Success)success failure:(Failure) failure;

// Seasons operations.
- (void)getSeason:(SeasonSynopsis *)season success:(Success)success failure:(Failure) failure;

// Episodes operations.
- (void)getEpisode:(EpisodeSynopsis *)episode success:(Success)success failure:(Failure) failure;

// Ratings operations.
- (void)getTvShowRating:(TvShow *)tvshow success:(Success)success failure:(Failure) failure;
- (void)getEpisodeRating:(Episode *)episode success:(Success)success failure:(Failure) failure;
- (void)postTvShowRating:(TvShow *)tvshow rating:(float)rating success:(Success)success failure:(Failure) failure;
- (void)postEpisodeRating:(Episode *)episode rating:(float)rating success:(Success)success failure:(Failure) failure;

// Comments operations.
- (void)getTvshowComments:(TvShow *)tvshow success:(Success)success failure:(Failure) failure;
- (void)getEpisodeComments:(Episode *)episode success:(Success)success failure:(Failure) failure;
- (void)postTvShowComment:(TvShow *)tvshow comment:(NSString *)comment success:(Success)success failure:(Failure) failure;
- (void)postEpisodeComment:(Episode *)episode comment:(NSString *)comment success:(Success)success failure:(Failure) failure;
- (void)deleteComment:(Comment *)comment success:(Success)success failure:(Failure) failure;

// Subscriptions operations.
- (void)getSubscriptions:(Success)success failure:(Failure) failure;
- (void)postSubscription:(TvShow *)tvshow success:(Success)success failure:(Failure) failure;
//- (void)deleteSubscription:(TvShow *)tvshow success:(Success)success failure:(Failure) failure;

@end
