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

@end
