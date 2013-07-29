//
//  Subscription.m
//  STracker
//
//  Created by Ricardo Sousa on 10/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Subscription.h"
#import "Episode.h"

@implementation Subscription

@synthesize tvshow, episodesWatched;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        tvshow = [parameters objectForKey:@"TvShowId"];
        
        NSMutableArray *episodesAux = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"EpisodesWatched"])
        {
            EpisodeSynopsis *episode = [[EpisodeSynopsis alloc] initWithDictionary:item];
            [episodesAux addObject:episode];
        }
        episodesWatched = episodesAux;
    }
    
    return self;
}

@end