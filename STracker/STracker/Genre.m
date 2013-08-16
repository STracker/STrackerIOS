//
//  Genre.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Genre.h"
#import "TvShow.h"

@implementation Genre

@synthesize name, tvshows;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super initWithDictionary:parameters])
    {
        name = [parameters objectForKey:@"Id"];
        
        NSMutableArray *tvshowsAux = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"Tvshows"])
        {
            TvShowSynopsis *tvshow = [[TvShowSynopsis alloc] initWithDictionary:item];
            [tvshowsAux addObject:tvshow];
        }
        tvshows = tvshowsAux;
    }
    
    return self;
}

@end

#pragma mark - Synopsis object.
@implementation GenreSynopsis

- (id)initWithDictionary:(NSDictionary *)parameters
{
    return [super initWithDictionary:parameters];
}

@end