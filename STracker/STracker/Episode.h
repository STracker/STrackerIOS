//
//  Episode.h
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"

/*!
 @discussion This object defines the episode entity object.
 */
@interface Episode : Entity

@property(nonatomic, copy) NSString *TvShowId;
@property(nonatomic, copy) NSString *SeasonNumber;
@property(nonatomic, copy) NSString *EpisodeNumber;
@property(nonatomic, copy) NSString *Name;
@property(nonatomic, copy) NSString *Description;
@property(nonatomic, copy) NSString *Date;
@property(nonatomic, copy) NSString *Poster;
@property(nonatomic, retain) NSArray *Directors;
@property(nonatomic, retain) NSArray *GuestActors;

@end

/*!
 @discussion This object defines the episode synopse entity object.
 */
@interface EpisodeSynopse : Entity

@property(nonatomic, copy) NSString *EpisodeNumber;
@property(nonatomic, copy) NSString *Name;
@property(nonatomic, copy) NSString *Date;

@end