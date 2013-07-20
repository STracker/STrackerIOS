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

@synthesize TvShowId, Name, Description, Runtime, FirstAired, AirDay, Genres, SeasonSynopses, Actors, Rating, RatingTotalUsers;

/*
 According to Jastor documentation, is necessary to define this methods 
 for returning the class object, when the objects are array type.
 */
- (Class)Genres_class
{
    return [GenreSynopse class];
}

- (Class)SeasonSynopses_class
{
    return [SeasonSynopse class];
}

- (Class)Actors_class
{
    return [Actor class];
}

@end

@implementation TvShowSynopse

@synthesize TvShowId, Name, Poster;

@end