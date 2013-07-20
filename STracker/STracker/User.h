//
//  User.h
//  STracker
//
//  Created by Ricardo Sousa on 06/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Person.h"

/*!
 @discussion This object defines the user entity object.
 */
@interface User : Person

@property(nonatomic, copy) NSString *Key;
@property(nonatomic, copy) NSString *Email;
@property(nonatomic, strong) NSArray *Friends;
@property(nonatomic, strong) NSArray *SubscriptionList;

@end

/*!
 @discussion This object defines the actor synopse entity object.
 */
@interface UserSinopse : Entity

@property(nonatomic, copy) NSString *Id;
@property(nonatomic, copy) NSString *Name;

@end
