//
//  Episode.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Episode.h"

@implementation Episode

@synthesize number, name, description, date, poster, directors, guestActors;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        number = [Entity verifyValue:[dictionary objectForKey:@"SeasonNumber"] defaultValue:@"N/A"];
        name = [Entity verifyValue:[dictionary objectForKey:@"Name"] defaultValue:@"N/A"];
        description = [Entity verifyValue:[dictionary objectForKey:@"Description"] defaultValue:@"N/A"];
        date = [Entity verifyValue:[dictionary objectForKey:@"Date"] defaultValue:@"N/A"];
        
        NSDictionary *artwork = [dictionary objectForKey:@"Poster"];
        if ([artwork objectForKey:@"ImageUrl"] != nil)
        {
            poster = [Entity verifyValue:[artwork objectForKey:@"ImageUrl"] defaultValue:@"N/A"];
        }
        
        directors = [[NSMutableArray alloc] init];
        for (id item in [dictionary objectForKey:@"Directors"])
        {
            Person *person = [[Person alloc] initWithDictionary:item];
            [directors addObject:person];
        }
        
        guestActors = [[NSMutableArray alloc] init];
        for (id item in [dictionary objectForKey:@"GuestActors"])
        {
            Actor *actor = [[Actor alloc] initWithDictionary:item];
            [guestActors addObject:actor];
        }
    }
    
    return self;
}

@end

#pragma mark - Synopsis object.
@implementation EpisodeSynopsis

@synthesize number, name, uri;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        number = [Entity verifyValue:[dictionary objectForKey:@"EpisodeNumber"] defaultValue:@"N/A"];
        name = [Entity verifyValue:[dictionary objectForKey:@"Name"] defaultValue:@"N/A"];
        uri = [Entity verifyValue:[dictionary objectForKey:@"Uri"] defaultValue:@"N/A"];
    }
    
    return self;
}

@end
