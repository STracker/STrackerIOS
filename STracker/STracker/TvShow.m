//
//  TvShow.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShow.h"

@implementation TvShow

@synthesize imdbId, name, description;

- (TvShowSynopse *)getSynopse
{
    return [[TvShowSynopse alloc] init];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        imdbId = [dictionary objectForKey:@"TvShowId"];
        name = [dictionary objectForKey:@"Name"];
        description = [dictionary objectForKey:@"Description"];
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
        imdbId = [dictionary objectForKey:@"Id"];
        name = [dictionary objectForKey:@"Name"];
    }
    return self;
}

@end
