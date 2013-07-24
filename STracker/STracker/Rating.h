//
//  Rating.h
//  STracker
//
//  Created by Ricardo Sousa on 7/24/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"

/*!
 @discussion This object defines the rating entity object.
 */
@interface Rating : Entity

@property(nonatomic) int rating;
@property(nonatomic) int numberOfUsers;

@end