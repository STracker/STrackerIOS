//
//  Person.h
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"

@interface Person : Entity

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *photoURL;
@property(nonatomic, copy) UIImage *image;

@end
