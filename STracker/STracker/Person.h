//
//  Person.h
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"

/*!
 @discussion This object defines the person entity object.
 */
@interface Person : Entity

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *photoUrl;

@end

/*!
 @discussion This object defines the person synopse entity object.
 */
@interface PersonSynopse : EntitySynopse

@end