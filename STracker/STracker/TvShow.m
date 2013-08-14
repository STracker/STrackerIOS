//
//  TvShow.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShow.h"
#import "Genre.h"
#import "Season.h"
#import "Actor.h"

@implementation TvShow

@synthesize identifier, name, description, runtime, firstAired, airDay, genres, seasons, actors, rating, poster;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        identifier = [parameters objectForKey:@"Id"];
        name = [parameters objectForKey:@"Name"];
        description = [parameters objectForKey:@"Description"];
        runtime = [parameters objectForKey:@"Runtime"];
        airDay = [parameters objectForKey:@"AirDay"];
        firstAired = [parameters objectForKey:@"FirstAired"];
        poster = [parameters objectForKey:@"Poster"];
        
        NSMutableArray *genresAux = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"Genres"])
        {
            GenreSynopsis *genre = [[GenreSynopsis alloc] initWithDictionary:item];
            [genresAux addObject:genre];
        }
        genres = genresAux;
        
        NSMutableArray *seasonsAux = [[NSMutableArray alloc] init];
        for(NSDictionary *item in [parameters objectForKey:@"Seasons"])
        {
            SeasonSynopsis *season = [[SeasonSynopsis alloc] initWithDictionary:item];
            [seasonsAux addObject:season];
        }
        seasons = seasonsAux;
        
        NSMutableArray *actorsAux = [[NSMutableArray alloc] init];
        for(NSDictionary *item in [parameters objectForKey:@"Actors"])
        {
            Actor *season = [[Actor alloc] initWithDictionary:item];
            [actorsAux addObject:season];
        }
        actors = actorsAux;
    }
    
    return self;
}

@end

@implementation TvShowSynopsis

@synthesize identifier, poster;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        identifier = [parameters objectForKey:@"Id"];
        self.name = [parameters objectForKey:@"Name"];
        poster = [parameters objectForKey:@"Poster"];
        self.uri = [parameters objectForKey:@"Uri"];
    }
    
    return self;
}
@end