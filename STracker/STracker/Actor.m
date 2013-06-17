//
//  Actor.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Actor.h"

@implementation Actor

@synthesize characterName;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        characterName = [Entity verifyValue:[dictionary objectForKey:@"CharacterName"] defaultValue:@"N/A"];
    }
    
    return self;
}

@end