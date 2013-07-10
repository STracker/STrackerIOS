//
//  Subscription.h
//  STracker
//
//  Created by Ricardo Sousa on 10/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"
#import "TvShow.h"
#import "Episode.h"

@interface Subscription : Entity

@property(nonatomic, strong) TvShowSynopse *tvshow;
@property(nonatomic, strong) NSMutableArray *episodesWatched;

@end
