//
//  TvShow.h
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

@class Rating;

/*!
 @discussion This object defines the television show entity object.
 */
@interface TvShow : Entity <Deserialize, EntityDelegate>

@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *description;
@property(nonatomic, copy) NSString *runtime;
@property(nonatomic, copy) NSString *airDay;
@property(nonatomic, copy) NSString *firstAired;
@property(nonatomic, copy) NSString *airTime;
@property(nonatomic, copy) NSString *poster;
@property(nonatomic, strong) NSArray *genres;
@property(nonatomic, strong) NSArray *seasons;
@property(nonatomic, strong) NSArray *actors;
@property(nonatomic, strong) Rating *rating;

@end

/*!
 @discussion This object defines the television show synopsis entity object.
 */
@interface TvShowSynopsis : EntitySynopsis <Deserialize>

@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, copy) NSString *poster;

@end