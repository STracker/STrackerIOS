//
//  Season.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Season.h"
#import "Episode.h"

@implementation SeasonId

@synthesize tvshowId, seasonNumber;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        tvshowId = [parameters objectForKey:@"TvShowId"];
        seasonNumber = [[parameters objectForKey:@"SeasonNumber"] intValue];
    }
    
    return self;
}

@end

@implementation Season

@synthesize identifier, episodes;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super initWithDictionary:parameters])
    {
        identifier = [[SeasonId alloc] initWithDictionary:[parameters objectForKey:@"Id"]];
        
        NSMutableArray *episodesAux = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"Episodes"])
        {
            EpisodeSynopsis *episode = [[EpisodeSynopsis alloc] initWithDictionary:item];
            [episodesAux addObject:episode];
        }
        episodes = episodesAux;
    }
    
    return self;
}

@end

#pragma mark - Synopsis object.
@implementation SeasonSynopsis

@synthesize identifier;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super initWithDictionary:parameters])
        identifier = [[SeasonId alloc] initWithDictionary:[parameters objectForKey:@"Id"]];

    return self;
}

@end