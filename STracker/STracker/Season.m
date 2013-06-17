//
//  Season.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Season.h"

@implementation Season

@synthesize number, episodesSynopsis;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        number = [Entity verifyValue:[dictionary objectForKey:@"SeasonNumber"] defaultValue:@"N/A"];
        
        episodesSynopsis = [[NSMutableArray alloc] init];
        for (id item in [dictionary objectForKey:@"EpisodeSynopses"])
        {
            EpisodeSynopsis *episode = [[EpisodeSynopsis alloc] initWithDictionary:item];
            [episodesSynopsis addObject:episode];
        }
    }
    
    return self;
}

@end

#pragma mark - Synopsis object.
@implementation SeasonSynopsis

@synthesize number, uri;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        number = [Entity verifyValue:[dictionary objectForKey:@"SeasonNumber"] defaultValue:@"N/A"];
        uri = [Entity verifyValue:[dictionary objectForKey:@"Uri"] defaultValue:@"N/A"];
    }
    
    return self;
}

@end
