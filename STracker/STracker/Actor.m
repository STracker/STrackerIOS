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

-(id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super initWithDictionary:parameters])
        characterName = [parameters objectForKey:@"CharacterName"];
    
    return self;
}

@end 