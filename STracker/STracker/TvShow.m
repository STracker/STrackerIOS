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
    if (self = [super initWithDictionary:parameters])
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

- (EntitySynopsis *)getSynopsis
{
    TvShowSynopsis *synopsis = [[TvShowSynopsis alloc] init];
    synopsis.name = [self identifier];
    
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerTvShowsURI"];
    uri = [uri stringByAppendingFormat:@"/%@", [self identifier]];
    synopsis.uri = uri;
    
    synopsis.identifier = [self identifier];
    synopsis.poster = [self poster];
    
    return synopsis;
}

@end

#pragma mark - Synopsis object.
@implementation TvShowSynopsis

@synthesize identifier, poster;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super initWithDictionary:parameters])
    {
        identifier = [parameters objectForKey:@"Id"];
        poster = [parameters objectForKey:@"Poster"];
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
        self.poster = [aCoder decodeObjectForKey:@"Poster"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"Name"];
    [coder encodeObject:self.uri forKey:@"Uri"];
    [coder encodeObject:self.identifier forKey:@"Id"];
    [coder encodeObject:self.poster forKey:@"Poster"];
}

@end