//
//  Comment.m
//  STracker
//
//  Created by Ricardo Sousa on 7/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Comment.h"

@implementation Comment

@synthesize identifier, userId, body;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        identifier = [Entity verifyValue:[dictionary objectForKey:@"Id"] defaultValue:@"N/A"];
        userId = [Entity verifyValue:[dictionary objectForKey:@"UserId"] defaultValue:@"N/A"];
        body = [Entity verifyValue:[dictionary objectForKey:@"Body"] defaultValue:@"N/A"];
    }
    
    return self;
}
@end