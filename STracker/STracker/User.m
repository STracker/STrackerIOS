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

@synthesize identifier, email, friends, subscriptions;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super initWithDictionary:parameters])
    {
        identifier = [parameters objectForKey:@"Key"];
        email = [parameters objectForKey:@"Email"];
        
        NSMutableArray *friendsAux = [[NSMutableArray alloc] init];
        for (NSDictionary * item in [parameters objectForKey:@"Friends"])
        {
            User *friend = [[User alloc] initWithDictionary:item];
            [friendsAux addObject:friend];
        }
        friends = friendsAux;
        
        NSMutableArray *subscriptionsAux = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"SubscriptionList"])
        {
            Subscription *subscription = [[Subscription alloc] initWithDictionary:item];
            [subscriptionsAux addObject:subscription];
        }
        subscriptions = subscriptionsAux;
    }
    
    return self;
}

@end

@implementation UserSinopse

@synthesize identifier;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super initWithDictionary:parameters])
        identifier = [parameters objectForKey:@"Id"];
    
    return self;
}

@end
