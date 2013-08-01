//
//  Suggestion.h
//  STracker
//
//  Created by Ricardo Sousa on 01/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"
#import "TvShow.h"
#import "User.h"

/*!
 @discussion This object defines the suggestion entity object.
 */
@interface Suggestion : Entity

@property(nonatomic, strong) UserSynopsis *user;
@property(nonatomic, strong) TvShowSynopsis *tvshow;

@end
