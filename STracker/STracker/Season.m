//
//  Season.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Season.h"
#import "Episode.h"

@implementation Season

@synthesize tvshowId, seasonNumber, episodes;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        tvshowId = [parameters objectForKey:@"TvShowId"];
        seasonNumber = [parameters objectForKey:@"SeasonNumber"];
        
        NSMutableArray *episodesAux = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"EpisodesSynopses"])
        {
            EpisodeSynopse *episode = [[EpisodeSynopse alloc] initWithDictionary:item];
            [episodesAux addObject:episode];
        }
        episodes = episodesAux;
    }
    
    return self;
}

@end

#pragma mark - Synopsis object.
@implementation SeasonSynopse

@synthesize tvshowId, seasonNumber;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        tvshowId = [parameters objectForKey:@"TvShowId"];
        seasonNumber = [parameters objectForKey:@"SeasonNumber"];
        self.name = [NSString stringWithFormat:@"Season %@", seasonNumber];
        self.uri = [parameters objectForKey:@"Uri"];
    }

    return self;
}


@end