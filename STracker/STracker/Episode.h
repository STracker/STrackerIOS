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

@property(nonatomic, copy) NSString *tvshowId;
@property(nonatomic) int seasonNumber;
@property(nonatomic) int episodeNumber;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *description;
@property(nonatomic, copy) NSString *date;
@property(nonatomic, copy) NSString *poster;
@property(nonatomic, retain) NSArray *directors;
@property(nonatomic, retain) NSArray *guestActors;

@end

/*!
 @discussion This object defines the episode synopse entity object.
 */
@interface EpisodeSynopse : EntitySynopse

@property(nonatomic, copy) NSString *tvshowId;
@property(nonatomic) int seasonNumber;
@property(nonatomic) int episodeNumber;
@property(nonatomic, copy) NSString *date;

@end