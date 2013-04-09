//
//  TvShow.h
//  STracker
//
//  Created by Ricardo Sousa on 09/04/13.
//  Copyright (c) 2013 Ricardo Sousa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Actor.h"

@interface TvShow : NSObject

@property(nonatomic, retain) NSString *Id;
@property(nonatomic, retain) NSString *Name;
@property(nonatomic, retain) NSString *Description;
@property(nonatomic, retain) NSMutableArray *Actors;
@property(nonatomic, retain) NSMutableArray *Seasons;

@end
