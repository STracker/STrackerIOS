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

#pragma mark - Encode and decode methods for use in Core Data user entity.

- (id)initWithCoder: (NSCoder *)aCoder
{
    self = [super init];
    if (self)
    {
        self.tvshowId = [aCoder decodeObjectForKey:@"TvShowId"];
        self.seasonNumber = [aCoder decodeInt32ForKey:@"SeasonNumber"];
        self.episodeNumber = [aCoder decodeInt32ForKey:@"EpisodeNumber"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.tvshowId forKey:@"TvShowId"];
    [coder encodeInt32:self.seasonNumber forKey:@"SeasonNumber"];
    [coder encodeInt32:self.episodeNumber forKey:@"EpisodeNumber"];
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

- (NSString *)constructNumber
{
    NSString *seasonN;
    if (self.identifier.seasonNumber < 9)
        seasonN = [NSString stringWithFormat:@"S0%d", self.identifier.seasonNumber];
    else
        seasonN = [NSString stringWithFormat:@"S%d", self.identifier.seasonNumber];
    
    NSString *episodeN;
    if (self.identifier.episodeNumber < 9)
        episodeN = [NSString stringWithFormat:@"E0%d", self.identifier.episodeNumber];
    else
        episodeN = [NSString stringWithFormat:@"E%d", self.identifier.episodeNumber];
    
    return [NSString stringWithFormat:@"%@%@ - %@",seasonN, episodeN, self.name];
}

- (EpisodeSynopsis *)getSynopsis
{
    EpisodeSynopsis *synopsis = [[EpisodeSynopsis alloc] init];
    synopsis.name = self.name;
    
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerEpisodesURI"];
    uri = [uri stringByReplacingOccurrencesOfString:@"tvshowId" withString:self.identifier.tvshowId];
    uri = [uri stringByReplacingOccurrencesOfString:@"seasonNumber" withString:[NSString stringWithFormat:@"%d", self.identifier.seasonNumber]];
    uri = [uri stringByReplacingOccurrencesOfString:@"episodeNumber" withString:[NSString stringWithFormat:@"%d", self.identifier.episodeNumber]];
    
    synopsis.uri = uri;
    synopsis.identifier = self.identifier;
    synopsis.date = self.date;
    
    return synopsis;
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

- (NSString *)constructNumber
{
    NSString *seasonN;
    if (self.identifier.seasonNumber < 9)
        seasonN = [NSString stringWithFormat:@"S0%d", self.identifier.seasonNumber];
    else
        seasonN = [NSString stringWithFormat:@"S%d", self.identifier.seasonNumber];
    
    NSString *episodeN;
    if (self.identifier.episodeNumber < 9)
        episodeN = [NSString stringWithFormat:@"E0%d", self.identifier.episodeNumber];
    else
        episodeN = [NSString stringWithFormat:@"E%d", self.identifier.episodeNumber];
    
    return [NSString stringWithFormat:@"%@%@ - %@",seasonN, episodeN, self.name];
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
