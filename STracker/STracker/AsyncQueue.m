//
//  AsyncQueue.m
//  STracker
//
//  Created by Ricardo Sousa on 18/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "AsyncQueue.h"

@implementation AsyncQueue

/*!
 @discussion Override the init method, for set some properties.
 */
- (id)init
{
    if (self = [super init])
        // Create the queue for images.
        _queue = dispatch_queue_create("asyncQueue", nil);
    
    return self;
}

#pragma mark - DownloadFiles public methods.

+ (id)sharedObject
{
    static AsyncQueue *sharedObject = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[AsyncQueue alloc] init];
    });
    
    return sharedObject;
}

- (void)performAsyncOperation:(Block) block
{
    // Make the async dispatch to GCD.
    dispatch_async(_queue, block);
}

@end
