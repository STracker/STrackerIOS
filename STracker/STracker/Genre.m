//
//  Genre.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Genre.h"

@implementation Genre

@synthesize name, tvshows;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        name = [Entity verifyValue:[dictionary objectForKey:@"Id"] defaultValue:@"N/A"];
    }
    
    return self;
}

@end

#pragma mark - Synopsis object.
@implementation GenreSynopsis

@synthesize name, uri;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        name = [Entity verifyValue:[dictionary objectForKey:@"Id"] defaultValue:@"N/A"];
        uri = [Entity verifyValue:[dictionary objectForKey:@"Uri"] defaultValue:@"N/A"];
    }
    
    return self;
}

@end