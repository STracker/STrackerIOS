//
//  Suggestion.h
//  STracker
//
//  Created by Ricardo Sousa on 01/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"

@class UserSynopsis;
@class TvShowSynopsis;

/*!
 @discussion This object defines the suggestion entity object.
 */
@interface Suggestion : NSObject <Deserialize>

@property(nonatomic, strong) UserSynopsis *user;
@property(nonatomic, strong) TvShowSynopsis *tvshow;

@end