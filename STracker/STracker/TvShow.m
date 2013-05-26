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

@end

#pragma mark - Synopsis object.
@implementation TvShowSynopse

@synthesize imdbId, name;

@end
