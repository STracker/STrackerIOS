//
//  Entity.m
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"

@implementation Entity

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
    return nil;
}

+ (id)verifyValue: (id)value defaultValue:(id)defaultValue
{
    return [[NSString stringWithFormat:@"%@", value] isEqual:@"<null>"] ? defaultValue : value;
}

@end