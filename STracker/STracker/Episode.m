//
//  Episode.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Episode.h"
#import "Actor.h"

@implementation Episode

@synthesize TvShowId, SeasonNumber, EpisodeNumber, Name, Description, Date, Poster, Directors, GuestActors;

/*
 According to Jastor documentation, is necessary to define this methods
 for returning the class object, when the objects are array type.
 */
- (Class)Directors_class
{
    return [Person class];
}

- (Class)GuestActors_class
{
    return [Actor class];
}

@end

@implementation EpisodeSynopse

@synthesize EpisodeNumber, Name, Date;

@end
