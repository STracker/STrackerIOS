//
//  Season.h
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"

/*!
 @discussion This object defines the season entity object.
 */
@interface Season : Entity

@property(nonatomic, copy) NSString *tvshowId;
@property(nonatomic, copy) NSString *seasonNumber;
@property(nonatomic, retain) NSArray *episodes;

@end

/*!
 @discussion This object defines the season synopse entity object.
 */
@interface SeasonSynopse : EntitySynopse

@property(nonatomic, copy) NSString *tvshowId;
@property(nonatomic, copy) NSString *seasonNumber;

@end
