//
//  User.m
//  STracker
//
//  Created by Ricardo Sousa on 06/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "User.h"
#import "Subscription.h"

@implementation User

@synthesize Key, Email, Friends, SubscriptionList;

/*
 According to Jastor documentation, is necessary to define this methods
 for returning the class object, when the objects are array type.
 */
- (Class)Friends_class
{
    return [UserSinopse class];
}

- (Class)SubscriptionList_class
{
    return [Subscription class];
}

@end

@implementation UserSinopse

@synthesize Id, Name;

@end
