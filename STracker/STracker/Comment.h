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

@property(nonatomic, copy) NSString *Id;
@property(nonatomic, copy) NSString *Body;
@property(nonatomic, strong) UserSinopse *User;
@property(nonatomic, copy) NSString *Uri;

@end