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
 @discussion This object defines the subscription object.
 */
@interface Subscription : NSObject <Deserialize>

@property(nonatomic, strong) TvShowSynopsis *tvshow;
@property(nonatomic, strong) NSMutableArray *episodesWatched;

@end