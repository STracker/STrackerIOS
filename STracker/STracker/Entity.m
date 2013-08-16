//
//  Entity.m
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"

@implementation Entity

@synthesize version;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
        version = [[parameters objectForKey:@"Version"] intValue];
    
    return self;
}

@end

#pragma mark - Synopsis object.
@implementation EntitySynopsis

@synthesize name, uri;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        name = [parameters objectForKey:@"Name"];
        uri = [parameters objectForKey:@"Uri"];
    }
    
    return self;
}

@end