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
    if (self = [super init])
    {
        name = [parameters objectForKey:@"Id"];
        
        NSMutableArray *tvshowsAux = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"TvShowsSinopses"])
        {
            TvShowSynopsis *tvshow = [[TvShowSynopsis alloc] initWithDictionary:item];
            [tvshowsAux addObject:tvshow];
        }
        tvshows = tvshowsAux;
    }
    
    return self;
}

@end

@implementation GenreSynopsis

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        self.name = [parameters objectForKey:@"Id"];
        self.uri = [parameters objectForKey:@"Uri"];
    }
    
    return self;
}

@end