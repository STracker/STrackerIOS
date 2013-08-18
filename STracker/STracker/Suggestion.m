//
//  Suggestion.m
//  STracker
//
//  Created by Ricardo Sousa on 01/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Suggestion.h"

@implementation Suggestion

@synthesize user, tvshow;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        user = [[UserSynopsis alloc] initWithDictionary:[parameters objectForKey:@"User"]];
        
        tvshow = [[TvShowSynopsis alloc] initWithDictionary:[parameters objectForKey:@"TvShow"]];
    }
     
    return self;
}

#pragma mark - Encode and decode methods for use in Core Data user entity.

- (id)initWithCoder: (NSCoder *)aCoder
{
    self = [super init];
    if (self)
    {
        self.user = [aCoder decodeObjectForKey:@"User"];
        self.tvshow = [aCoder decodeObjectForKey:@"TvShow"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.user forKey:@"User"];
    [coder encodeObject:self.tvshow forKey:@"TvShow"];
}

@end
