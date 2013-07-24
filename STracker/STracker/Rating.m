//
//  Rating.m
//  STracker
//
//  Created by Ricardo Sousa on 7/24/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Rating.h"

@implementation Rating

@synthesize rating, numberOfUsers;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        rating = [[parameters objectForKey:@"Rating"] intValue];
        numberOfUsers = [[parameters objectForKey:@"Total"] intValue];
    }
    
    return self;
}

@end