//
//  InfoController.m
//  STracker
//
//  Created by Ricardo Sousa on 23/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "InfoController.h"

@implementation InfoController

/*!
 @discussion Override init method for set _app field. This 
 field is by all info controllers.
 */
- (id)init
{
    if (self = [super init])
        _app = [[UIApplication sharedApplication] delegate];
    
    return self;
}

/*!
 @discussion Supposed to be abstract method...
 */
+ (id)sharedObject
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
    
    return nil;
}

@end