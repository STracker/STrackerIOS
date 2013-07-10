//
//  Subscription.m
//  STracker
//
//  Created by Ricardo Sousa on 10/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Subscription.h"

@implementation Subscription

@synthesize tvshow, episodesWatched;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        tvshow = [[TvShowSynopse alloc] initWithDictionary:[dictionary objectForKey:@"TvShow"]];
        
        episodesWatched = [[NSMutableArray alloc] init];
        
        for (NSDictionary *item in [dictionary objectForKey:@"EpisodesWatched"])
        {
            EpisodeSynopsis *synopsis = [[EpisodeSynopsis alloc] initWithDictionary:item];
            [episodesWatched addObject:synopsis];
        }
    }
    
    return self;
}

@end