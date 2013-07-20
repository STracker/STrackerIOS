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

@property(nonatomic, copy) NSString *tvshowId;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *description;
@property(nonatomic, copy) NSString *runtime;
@property(nonatomic, copy) NSString *airDay;
@property(nonatomic, copy) NSString *firstAired;
@property(nonatomic, copy) NSString *poster;
@property(nonatomic, retain) NSArray *genres;
@property(nonatomic, retain) NSArray *seasons;
@property(nonatomic, retain) NSArray *actors;
@property(nonatomic) double rating;
@property(nonatomic) int ratingTotalUsers;

@end

/*!
 @discussion This object defines the television show synopse entity object.
 */
@interface TvShowSynopse : EntitySynopse

@property(nonatomic, copy) NSString *tvshowId;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *poster;

@end