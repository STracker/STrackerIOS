//
//  Entity.m
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"

@implementation Entity

- (id)initWithDictionary:(NSDictionary *)parameters
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
    return nil;
}

@end

@implementation EntitySynopse

@synthesize name, uri;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
    return nil;
}

@end