//
//  TvShow.h
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

@interface TvShowSynopse : Entity

@property(nonatomic, copy) NSString *imdbId;
@property(nonatomic, copy) NSString *name;

@end

@interface TvShow : Entity

@property(nonatomic, copy) NSString *imdbId;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *description;
@property(nonatomic, copy) NSString *runtime;
@property(nonatomic, copy) NSString *airDay;
@property(nonatomic, copy) NSString *firstAired;
@property(nonatomic, copy) NSString *poster;
@property(nonatomic, retain) NSMutableArray *genres;

- (TvShowSynopse *)getSynopse;

@end