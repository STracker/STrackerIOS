//
//  STrackerTests.m
//  STrackerTests
//
//  Created by Ricardo Sousa on 8/17/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowInformationTests.h"
#import "TvShowsRequests.h"
#import "TvShow.h"
#import "SeasonsRequests.h"
#import "Season.h"
#import "EpisodesRequests.h"
#import "Episode.h"
#import "Range.h"

@implementation TvShowInformationTests

/*!
 @discussion Get By name.
 */
- (void) testGetByName
{
    __block BOOL done = NO;
    __block TvShowSynopsis *tvshow;
    
    Range *range = [[Range alloc] init];
    range.start = 0;
    range.end = 0;
    
    [TvShowsRequests getTvShowsByName:@"Breaking Bad" withRange:range finish:^(NSArray *tvshows) {
        tvshow = [tvshows objectAtIndex:0];
        done = YES;
    }];
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:30];
    while (!done && [loopUntil timeIntervalSinceNow] > 0)
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:loopUntil];
    
    if (done)
    {
        STAssertEqualObjects(tvshow.identifier, @"tt0903747", @"tvshow id");
        STAssertEqualObjects(tvshow.name, @"Breaking Bad", @"tvshow name");
        STAssertEqualObjects(tvshow.uri, @"tvshows/tt0903747", @"tvshow uri");
    }
}

/*!
 @discussion Get tv show basic information.
*/
- (void) testGetTvShow
{
    __block BOOL done = NO;
    __block TvShow *tvshow;
    
    NSString *uri = @"tvshows/tt0903747";
    [TvShowsRequests getTvShow:uri finish:^(id obj) {
        tvshow = obj;
        done = YES;
    }];
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:30];
    while (!done && [loopUntil timeIntervalSinceNow] > 0)
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:loopUntil];
    
    if (done)
    {
        STAssertEqualObjects(tvshow.identifier, @"tt0903747", @"tvshow id");
        STAssertEqualObjects(tvshow.name, @"Breaking Bad", @"tvshow name");
        STAssertEquals([tvshow.runtime integerValue], 60, @"tvshow runtime");
    }
}

/*!
 @discussion Get season information. 
 Used the season one.
 */
- (void) testGetSeason
{
    __block BOOL done = NO;
    __block Season *season;
    
    NSString *uri = @"tvshows/tt0903747/seasons/1";
    [SeasonsRequests getSeason:uri finish:^(id obj) {
        season = obj;
        done = YES;
    }];
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:30];
    while (!done && [loopUntil timeIntervalSinceNow] > 0)
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:loopUntil];
    
    if (done)
    {
        STAssertEqualObjects(season.identifier.tvshowId, @"tt0903747", @"season - tvshow id");
        STAssertEquals(season.identifier.seasonNumber, 1, @"season number");
        NSUInteger max = 7;
        STAssertEquals(season.episodes.count, max, @"season episodes count");
    }
}

/*!
 @discussion Get episode information.
 Used the first episode from season one.
 */
- (void) testGetEpisode
{
    __block BOOL done = NO;
    __block Episode *episde;
    
    NSString *uri = @"tvshows/tt0903747/seasons/1/episodes/1";
    [EpisodesRequests getEpisode:uri finish:^(id obj) {
        episde = obj;
        done = YES;
    }];
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:30];
    while (!done && [loopUntil timeIntervalSinceNow] > 0)
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:loopUntil];
    
    if (done)
    {
        STAssertEqualObjects(episde.identifier.tvshowId, @"tt0903747", @"episode - tvshow id");
        STAssertEquals(episde.identifier.seasonNumber, 1, @"episode - season number");
        STAssertEquals(episde.identifier.episodeNumber, 1, @"episode number");
        STAssertEqualObjects(episde.name, @"Pilot", @"episode name");
        STAssertEqualObjects(episde.date, @"2008-01-20", @"episode date");
    }
}

/*!
 @disucssion Get the top rated television shows.
 */
- (void) testTopRated
{
    __block BOOL done = NO;
    __block NSArray *tvshows;
    
    [TvShowsRequests getTvShowsTopRated:^(id obj) {
        tvshows = obj;
        done = YES;
    }];
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:30];
    while (!done && [loopUntil timeIntervalSinceNow] > 0)
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:loopUntil];
    
    if (done)
    {
        NSUInteger max = 8;
        STAssertEquals(tvshows.count, max, @"number of tvshows in top rated");
    }
}

@end
