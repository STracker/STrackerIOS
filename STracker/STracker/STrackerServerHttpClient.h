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

// Define the callbacks.
typedef void (^Success)(AFJSONRequestOperation *operation, id result);
typedef void (^Failure)(AFJSONRequestOperation *operation, NSError *error);

@interface STrackerServerHttpClient : AFHTTPClient

// Class method that returns a shared singleton instance.
+ (id)sharedClient;

// For errors.
+ (UIAlertView *)getAlertForError:(NSError *)error;

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

@end
