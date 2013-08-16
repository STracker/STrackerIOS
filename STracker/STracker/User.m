//
//  User.m
//  STracker
//
//  Created by Ricardo Sousa on 06/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "User.h"
#import "Subscription.h"
#import "Suggestion.h"

@implementation User

@synthesize identifier, name, photoUrl, email, friends, subscriptions, friendRequests, suggestions;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super initWithDictionary:parameters])
    {
        identifier = [parameters objectForKey:@"Id"];
        name = [parameters objectForKey:@"Name"];
        photoUrl = [parameters objectForKey:@"Photo"];
        email = [parameters objectForKey:@"Email"];
        
        NSMutableArray *friendsAux = [[NSMutableArray alloc] init];
        for (NSDictionary * item in [parameters objectForKey:@"Friends"])
        {
            UserSynopsis *friend = [[UserSynopsis alloc] initWithDictionary:item];
            [friendsAux addObject:friend];
        }
        friends = friendsAux;
        
        NSMutableArray *subscriptionsAux = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"Subscriptions"])
        {
            Subscription *subscription = [[Subscription alloc] initWithDictionary:item];
            [subscriptionsAux addObject:subscription];
        }
        subscriptions = subscriptionsAux;
        
        NSMutableArray *friendRequestsAux = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"FriendRequests"])
        {
            UserSynopsis *request = [[UserSynopsis alloc] initWithDictionary:item];
            [friendRequestsAux addObject:request];
        }
        friendRequests = friendRequestsAux;
        
        NSMutableArray *suggestionsAux = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"Suggestions"])
        {
            Suggestion *suggestion = [[Suggestion alloc] initWithDictionary:item];
            [suggestionsAux addObject:suggestion];
        }
        suggestions = suggestionsAux;
    }
    
    return self;
}

@end

#pragma mark - Synopsis object.
@implementation UserSynopsis

@synthesize identifier, photoUrl, photo;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        identifier = [parameters objectForKey:@"Id"];
        photoUrl = [parameters objectForKey:@"Photo"];
    }
    
    return self;
}

@end
