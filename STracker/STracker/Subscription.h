//
//  Subscription.h
//  STracker
//
//  Created by Ricardo Sousa on 10/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"
#import "TvShow.h"

/*!
 @discussion This object defines the subscription entity object.
 */
@interface Subscription : Entity

@property(nonatomic, strong) TvShowSynopse *tvshow;
@property(nonatomic, strong) NSArray *episodesWatched;

@end