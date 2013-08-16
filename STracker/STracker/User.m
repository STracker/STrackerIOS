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
        
        friends = [[NSMutableDictionary alloc] init];
        for (NSDictionary * item in [parameters objectForKey:@"Friends"])
        {
            UserSynopsis *friend = [[UserSynopsis alloc] initWithDictionary:item];
            [friends setValue:friend forKey:friend.identifier];
        }
        
        subscriptions = [[NSMutableDictionary alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"Subscriptions"])
        {
            Subscription *subscription = [[Subscription alloc] initWithDictionary:item];
            [subscriptions setValue:subscription forKey:subscription.tvshow.identifier];
        }
        
        friendRequests = [[NSMutableDictionary alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"FriendRequests"])
        {
            UserSynopsis *request = [[UserSynopsis alloc] initWithDictionary:item];
            [friendRequests setValue:request forKey:request.identifier];
        }
        
        suggestions = [[NSMutableDictionary alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"Suggestions"])
        {
            Suggestion *suggestion = [[Suggestion alloc] initWithDictionary:item];
            [suggestions setValue:suggestion forKey:suggestion.tvshow.identifier];
        }
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
