//
//  Subscription.m
//  STracker
//
//  Created by Ricardo Sousa on 10/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Subscription.h"
#import "Episode.h"

@implementation Subscription

@synthesize TvShow, EpisodesWatched;

/*
 According to Jastor documentation, is necessary to define this method
 for returing the class object because the type of the object is array.
 */
- (Class)EpisodesWatched_class
{
    return [EpisodeSynopse class];
}

@end