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

@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, strong) NSArray *friends;
@property(nonatomic, strong) NSArray *subscriptions;
@property(nonatomic, strong) NSArray *suggestions;
@property(nonatomic, strong) NSArray *friendRequests;

@end

/*!
 @discussion This object defines the actor synopse entity object.
 */
@interface UserSynopsis : PersonSynopsis

@property(nonatomic, copy) NSString *identifier;

@end