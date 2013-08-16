//
//  Genre.h
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

/*!
 @discussion This object defines the genre entity object.
 */
@interface Genre : Entity

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSArray *tvshows;

@end 

/*!
 @discussion This object defines the genre synopsis entity object.
 */
@interface GenreSynopsis : EntitySynopsis

@end