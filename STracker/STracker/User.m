//
//  User.m
//  STracker
//
//  Created by Ricardo Sousa on 06/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize identifier, email, friends, subscriptions;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        identifier = [Entity verifyValue:[dictionary objectForKey:@"Key"] defaultValue:@"N/A"];
        email = [Entity verifyValue:[dictionary objectForKey:@"Email"] defaultValue:@"N/A"];
        
        friends = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [dictionary objectForKey:@"Friends"])
        {
            UserSinospis *friend = [[UserSinospis alloc] initWithDictionary:item];
            [friends addObject:friend];
        }
        
        subscriptions = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [dictionary objectForKey:@"SubscriptionList"])
        {
            Subscription *subscription = [[Subscription alloc] initWithDictionary:item];
            [subscriptions addObject:subscription];
        }
    }
    
    return self;
}

@end

@implementation UserSinospis

@synthesize identifier, name, uri;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        identifier = [Entity verifyValue:[dictionary objectForKey:@"Id"] defaultValue:@"N/A"];
        name = [Entity verifyValue:[dictionary objectForKey:@"Name"] defaultValue:@"N/A"];
        uri = [Entity verifyValue:[dictionary objectForKey:@"Uri"] defaultValue:@"N/A"];
    }
    
    return self;
}

@end
