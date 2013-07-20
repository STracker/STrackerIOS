//
//  TvShow.h
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

/*!
 @discussion This object defines the television show entity object.
 */
@interface TvShow : Entity

@property(nonatomic, copy) NSString *TvShowId;
@property(nonatomic, copy) NSString *Name;
@property(nonatomic, copy) NSString *Description;
@property(nonatomic, copy) NSString *Runtime;
@property(nonatomic, copy) NSString *AirDay;
@property(nonatomic, copy) NSString *FirstAired;
@property(nonatomic, copy) NSString *Poster;
@property(nonatomic, retain) NSArray *Genres;
@property(nonatomic, retain) NSArray *SeasonSynopses;
@property(nonatomic, retain) NSArray *Actors;
@property(nonatomic) double Rating;
@property(nonatomic) int RatingTotalUsers;

@end

/*!
 @discussion This object defines the television show synopse entity object.
 */
@interface TvShowSynopse : EntitySynopse

@property(nonatomic, copy) NSString *TvShowId;
@property(nonatomic, copy) NSString *Name;
@property(nonatomic, copy) NSString *Poster;

@end

