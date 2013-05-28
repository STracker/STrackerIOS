//
//  TvShow.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShow.h"

@implementation TvShow

@synthesize imdbId, name, description, runtime, airDay, firstAired, poster, genres;

- (TvShowSynopse *)getSynopse
{
    return [[TvShowSynopse alloc] init];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        imdbId = [Entity verifyValue:[dictionary objectForKey:@"TvShowId"] defaultValue:@"N/A"];
        name = [Entity verifyValue:[dictionary objectForKey:@"Name"] defaultValue:@"N/A"];
        description = [Entity verifyValue:[dictionary objectForKey:@"Description"] defaultValue:@"N/A"];
        runtime = [Entity verifyValue:[dictionary objectForKey:@"Runtime"] defaultValue:@"N/A"];
        airDay = [Entity verifyValue:[dictionary objectForKey:@"AirDay"] defaultValue:@"N/A"];
        firstAired = [Entity verifyValue:[dictionary objectForKey:@"FirstAired"] defaultValue:@"N/A"];
        
        NSDictionary *artworks = [dictionary objectForKey:@"Artworks"];
        for (NSDictionary *item in artworks) {
            poster = [Entity verifyValue:[item objectForKey:@"ImageUrl"] defaultValue:@"N/A"];
            break;
        }
        
        genres = [[NSMutableArray alloc] init];
        for (id item in [dictionary objectForKey:@"Genres"]) {
            [genres addObject:[Entity verifyValue:item defaultValue:@"N/A"]];
        }
        
    }
    return self;
}

@end

#pragma mark - Synopsis object.
@implementation TvShowSynopse

@synthesize imdbId, name;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        imdbId = [Entity verifyValue:[dictionary objectForKey:@"Id"] defaultValue:@"N/A"];
        name = [Entity verifyValue:[dictionary objectForKey:@"Name"] defaultValue:@"N/A"];
    }
    return self;
}

@end
