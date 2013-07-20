//
//  Season.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Season.h"
#import "Episode.h"

@implementation Season

@synthesize SeasonNumber, EpisodeSynopses;

/*
 According to Jastor documentation, is necessary to define this method
 for returing the class object because the type of the object is array.
 */
- (Class)EpisodeSynopses_class
{
    return [EpisodeSynopse class];
}

@end

#pragma mark - Synopsis object.
@implementation SeasonSynopse

@synthesize SeasonNumber;

@end