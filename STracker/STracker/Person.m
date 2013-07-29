//
//  Person.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize name, photoUrl;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        name = [parameters objectForKey:@"Name"];
        photoUrl = [parameters objectForKey:@"Photo"];
    }
    
    return self;
}

@end

@implementation PersonSynopsis

@synthesize photoUrl, photo;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        self.name = [parameters objectForKey:@"Name"];
        self.uri = [parameters objectForKey:@"Uri"];
        photoUrl = [parameters objectForKey:@"Photo"];
    }
    
    return self;
}

@end