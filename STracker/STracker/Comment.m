//
//  Comment.m
//  STracker
//
//  Created by Ricardo Sousa on 7/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Comment.h"

@implementation Comment

@synthesize identifier, body, user, uri;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        identifier = [parameters objectForKey:@"Id"];
        body = [parameters objectForKey:@"Body"];
        user = [[UserSinopse alloc] initWithDictionary:[parameters objectForKey:@"User"]];
        uri = [parameters objectForKey:@"Uri"];
    }  
    
    return self;
}

@end