//
//  Genre.h
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

@interface GenreSynopsis : Entity

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *uri;

@end

@interface Genre : Entity

@property(nonatomic, copy) NSString *name;
@property(nonatomic, retain) NSArray *tvshows;

@end