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
        tvshow = [[TvShowSynopsis alloc] initWithDictionary:[parameters objectForKey:@"TvShow"]];
        
        episodesWatched = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"EpisodesWatched"])
        {
            EpisodeSynopsis *episode = [[EpisodeSynopsis alloc] initWithDictionary:item];
            [episodesWatched addObject:episode];
        }
    }
    
    return self; 
}

#pragma mark - Encode and decode methods for use in Core Data user entity.

- (id)initWithCoder: (NSCoder *)aCoder
{
    self = [super init];
    if (self)
    {
        self.tvshow = [aCoder decodeObjectForKey:@"TvShow"];
        self.episodesWatched = [aCoder decodeObjectForKey:@"EpisodesWatched"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.tvshow forKey:@"TvShow"];
    [coder encodeObject:self.episodesWatched forKey:@"EpisodesWatched"];
}

@end