//
//  UserCalendar.m
//  STracker
//
//  Created by Ricardo Sousa on 22/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "UserCalendar.h"
#import "Episode.h"
#import "TvShow.h"

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

#pragma mark - Encode and decode methods for use in Core Data user entity.

- (id)initWithCoder: (NSCoder *)aCoder
{
    self = [super init];
    if (self)
        self.entries = [aCoder decodeObjectForKey:@"Entries"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.entries forKey:@"Entries"];
}

@end

@implementation UserCalendarEntry

@synthesize date, episodes;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        date = [parameters objectForKey:@"Date"];
        
        episodes = [[NSMutableArray alloc] init];
        for (NSDictionary *entry in [parameters objectForKey:@"Entries"])
        {
            for (NSDictionary *item in [entry objectForKey:@"Episodes"])
            {
                EpisodeCalendar *epiC = [[EpisodeCalendar alloc] init];
                epiC.tvshowName = [[entry objectForKey:@"TvShow"] objectForKey:@"Name"];
                epiC.episode = [[EpisodeSynopsis alloc] initWithDictionary:item];
                
                [episodes addObject:epiC];
            }
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
        self.date = [aCoder decodeObjectForKey:@"Date"];
        self.episodes = [aCoder decodeObjectForKey:@"Episodes"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.date forKey:@"Date"];
    [coder encodeObject:self.episodes forKey:@"Episodes"];
}

@end

@implementation EpisodeCalendar

@synthesize tvshowName, episode;

#pragma mark - Encode and decode methods for use in Core Data user entity.

- (id)initWithCoder: (NSCoder *)aCoder
{
    self = [super init];
    if (self)
    {
        self.tvshowName = [aCoder decodeObjectForKey:@"TvShowName"];
        self.episode = [aCoder decodeObjectForKey:@"Episode"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.tvshowName forKey:@"TvShowName"];
    [coder encodeObject:self.episode forKey:@"Episode"];
}

@end