//
//  Comment.h
//  STracker
//
//  Created by Ricardo Sousa on 7/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"
#import "User.h"

/*!
 @discussion This object defines the comment entity object.
 */
@interface Comment : Entity

@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, copy) NSString *body;
@property(nonatomic, strong) UserSinopse *user;
@property(nonatomic, copy) NSString *uri;

@end