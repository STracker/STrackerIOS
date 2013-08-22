//
//  UserCalendar.m
//  STracker
//
//  Created by Ricardo Sousa on 22/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "UserCalendar.h"
#import "Episode.h"

@implementation UserCalendar

@synthesize entries;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        NSMutableArray *entriesAux = [[NSMutableArray alloc] init];
        for (NSDictionary *item in parameters)
        {
            UserCalendarEntry *entry = [[UserCalendarEntry alloc] initWithDictionary:item];
            [entriesAux addObject:entry];
        }
        entries = entriesAux;
    }
    
    return self;
}

@end

@implementation UserCalendarEntry

@synthesize date, tvshow, episodes;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        date = [parameters objectForKey:@"Date"];
        
        for (NSDictionary *entry in [parameters objectForKey:@"Entries"])
        {
            tvshow = [[TvShowSynopsis alloc] initWithDictionary:[entry objectForKey:@"TvShow"]];
            
            NSMutableArray *episodesAux = [[NSMutableArray alloc] init];
            for (NSDictionary *item in [entry objectForKey:@"Episodes"])
            {
                EpisodeSynopsis *episode = [[EpisodeSynopsis alloc] initWithDictionary:item];
                [episodesAux addObject:episode];
            }
            episodes = episodesAux;
        }
    }
    
    return self;
}

@end