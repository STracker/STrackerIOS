//
//  Episode.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Episode.h"
#import "Actor.h"

@implementation EpisodeId

@synthesize tvshowId, seasonNumber, episodeNumber;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        tvshowId = [parameters objectForKey:@"TvShowId"];
        seasonNumber = [[parameters objectForKey:@"SeasonNumber"] intValue];
        episodeNumber = [[parameters objectForKey:@"EpisodeNumber"] intValue];
    }
    
    return self;
}

@end

@implementation Episode

@synthesize identifier, name, description, date, poster, directors, guestActors;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super initWithDictionary:parameters])
    {
        identifier = [[EpisodeId alloc] initWithDictionary:[parameters objectForKey:@"Id"]];
        name = [parameters objectForKey:@"Name"];
        description = [parameters objectForKey:@"Description"];
        date = [parameters objectForKey:@"Date"];
        poster = [parameters objectForKey:@"Poster"];
        
        NSMutableArray *directorsAux = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"Directors"])
        {
            Person *director = [[Person alloc] initWithDictionary:item];
            [directorsAux addObject:director];
        }
        directors = directorsAux;
        
        NSMutableArray *guestActorsAux = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"GuestActors"])
        {
            Actor *actor = [[Actor alloc] initWithDictionary:item];
            [guestActorsAux addObject:actor];
        }
        guestActors = guestActorsAux;
    }
    
    return self;
}

@end

#pragma mark - Synopsis object.
@implementation EpisodeSynopsis

@synthesize identifier, date;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super initWithDictionary:parameters])
    {
        identifier = [[EpisodeId alloc] initWithDictionary:[parameters objectForKey:@"Id"]];
        date = [parameters objectForKey:@"Date"];
    }
    
    return self;
}

#pragma mark - Encode and decode methods for use in Core Data user entity.

- (id)initWithCoder: (NSCoder *)aCoder
{
    self = [super init];
    if (self)
    {
        self.name = [aCoder decodeObjectForKey:@"Name"];
        self.uri = [aCoder decodeObjectForKey:@"Uri"];
        self.identifier = [aCoder decodeObjectForKey:@"Id"];
        self.date = [aCoder decodeObjectForKey:@"Date"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"Name"];
    [coder encodeObject:self.uri forKey:@"Uri"];
    [coder encodeObject:self.identifier forKey:@"Id"];
    [coder encodeObject:self.date forKey:@"Date"];
}


@end
