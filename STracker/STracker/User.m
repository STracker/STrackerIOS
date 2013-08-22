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
        
        suggestions = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"Suggestions"])
        {
            Suggestion *suggestion = [[Suggestion alloc] initWithDictionary:item];
            [suggestions addObject:suggestion];
        }
    }
    
    return self;
}

- (UserSynopsis *)getSynopsis
{
    UserSynopsis *synopsis = [[UserSynopsis alloc] init];
    synopsis.name = self.name;
    
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUsersURI"];
    uri = [uri stringByAppendingFormat:@"/%@", [self identifier]];
    synopsis.uri = uri;
    
    synopsis.identifier = self.identifier;
    synopsis.photoUrl = self.photoUrl;
    
    return synopsis;
}

@end

#pragma mark - Synopsis object.
@implementation UserSynopsis

@synthesize identifier, photoUrl, photo;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super initWithDictionary:parameters])
    {
        identifier = [parameters objectForKey:@"Id"];
        photoUrl = [parameters objectForKey:@"Photo"];
    }
    
    return self;
}

#pragma mark - Encode and decode methods for use in Core Data user entity.

- (id)initWithCoder: (NSCoder *)aCoder
{
    self = [super init];
    if (self)
    {
        self.name = [aCoder decodeObjectForKey:@"Name"];
        self.uri = [aCoder decodeObjectForKey:@"Uri"];
        self.identifier = [aCoder decodeObjectForKey:@"Id"];
        self.photoUrl = [aCoder decodeObjectForKey:@"Photo"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"Name"];
    [coder encodeObject:self.uri forKey:@"Uri"];
    [coder encodeObject:self.identifier forKey:@"Id"];
    [coder encodeObject:self.photoUrl forKey:@"Photo"];
}

@end
