//
//  TvShow.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShow.h"

@implementation TvShow

@synthesize imdbId, name, description, runtime, airDay, firstAired, poster, genres, seasons, actors;

- (TvShowSynopse *)getSynopse
{
    return [[TvShowSynopse alloc] init];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        imdbId = [Entity verifyValue:[dictionary objectForKey:@"TvShowId"] defaultValue:@"N/A"];
        name = [Entity verifyValue:[dictionary objectForKey:@"Name"] defaultValue:@"N/A"];
        description = [Entity verifyValue:[dictionary objectForKey:@"Description"] defaultValue:@"N/A"];
        runtime = [Entity verifyValue:[dictionary objectForKey:@"Runtime"] defaultValue:@"N/A"];
        airDay = [Entity verifyValue:[dictionary objectForKey:@"AirDay"] defaultValue:@"N/A"];
        firstAired = [Entity verifyValue:[dictionary objectForKey:@"FirstAired"] defaultValue:@"N/A"];
        
        NSDictionary *artwork = [dictionary objectForKey:@"Poster"];
        if ([artwork objectForKey:@"ImageUrl"] != nil) {
            poster = [Entity verifyValue:[artwork objectForKey:@"ImageUrl"] defaultValue:@"N/A"];
        }
        
        genres = [[NSMutableArray alloc] init];
        for (id item in [dictionary objectForKey:@"Genres"])
        {
            GenreSynopsis *genre = [[GenreSynopsis alloc] initWithDictionary:item];
            [genres addObject:genre];
        }
        
        seasons = [[NSMutableArray alloc] init];
        for (id item in [dictionary objectForKey:@"SeasonSynopses"])
        {
            SeasonSynopsis *season = [[SeasonSynopsis alloc] initWithDictionary:item];
            [seasons addObject:season];
        }
        
        actors = [[NSMutableArray alloc] init];
        for (id item in [dictionary objectForKey:@"Actors"])
        {
            Actor *actor = [[Actor alloc] initWithDictionary:item];
            [actors addObject:actor];
        }
    }
    return self;
}

@end

#pragma mark - Synopsis object.
@implementation TvShowSynopse

@synthesize imdbId, name, uri;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        imdbId = [Entity verifyValue:[dictionary objectForKey:@"Id"] defaultValue:@"N/A"];
        name = [Entity verifyValue:[dictionary objectForKey:@"Name"] defaultValue:@"N/A"];
        uri = [Entity verifyValue:[dictionary objectForKey:@"Uri"] defaultValue:@"N/A"];
    }
    return self;
}

@end
