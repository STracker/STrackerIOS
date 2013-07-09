//
//  Comment.h
//  STracker
//
//  Created by Ricardo Sousa on 7/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"

@interface Comment : Entity

@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, copy) NSString *userId;
@property(nonatomic, copy) NSString *body;

@end
