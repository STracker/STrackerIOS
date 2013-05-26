//
//  TvShow.h
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TvShowSynopse : NSObject

@property(nonatomic, copy) NSString *imdbId;
@property(nonatomic, copy) NSString *name;

@end

@interface TvShow : NSObject

@property(nonatomic, copy) NSString *imdbId;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *description;

- (TvShowSynopse *)getSynopse;

@end