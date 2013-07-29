//
//  Episode.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Episode.h"
#import "Actor.h"

@implementation Episode

@synthesize tvshowId, seasonNumber, episodeNumber, name, description, date, poster, directors, guestActors;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        tvshowId = [parameters objectForKey:@"TvShowId"];
        seasonNumber = [[parameters objectForKey:@"SeasonNumber"] intValue];
        episodeNumber = [[parameters objectForKey:@"EpisodeNumber"] intValue];
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

@implementation EpisodeSynopsis

@synthesize tvshowId, seasonNumber, episodeNumber, date;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        tvshowId = [parameters objectForKey:@"TvShowId"];
        seasonNumber = [[parameters objectForKey:@"SeasonNumber"] intValue];
        episodeNumber = [[parameters objectForKey:@"EpisodeNumber"] intValue];
        self.name = [parameters objectForKey:@"Name"];
        date = [parameters objectForKey:@"Date"];
        self.uri = [parameters objectForKey:@"Uri"];
    }
    
    return self;
}

@end
