//
//  Person.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize name, photoURL;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        name = [Entity verifyValue:[dictionary objectForKey:@"Name"] defaultValue:@"N/A"];

        @try
        {
            NSDictionary *artwork = [dictionary objectForKey:@"Photo"];
            photoURL = [Entity verifyValue:[artwork objectForKey:@"ImageUrl"] defaultValue:@"N/A"];
        }
        @catch (NSException *exception) {}
    }
    
    return self;
}

@end
