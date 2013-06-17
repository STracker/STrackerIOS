//
//  Season.h
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"
#import "Episode.h"

@interface SeasonSynopsis : Entity

@property(nonatomic, copy) NSString *number;
@property(nonatomic, copy) NSString *uri;

@end

@interface Season : Entity

@property(nonatomic, copy) NSString *number;
@property(nonatomic, retain) NSMutableArray *episodesSynopsis;

@end
