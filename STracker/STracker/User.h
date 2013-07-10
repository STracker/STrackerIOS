//
//  User.h
//  STracker
//
//  Created by Ricardo Sousa on 06/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Person.h"
#import "Subscription.h"

@interface User : Person

@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, strong) NSMutableArray *friends;
@property(nonatomic, strong) NSMutableArray *subscriptions;

@end

@interface UserSinospis : Entity

@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *uri;

@end
