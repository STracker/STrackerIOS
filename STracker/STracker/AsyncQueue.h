//
//  AsyncQueue.h
//  STracker
//
//  Created by Ricardo Sousa on 18/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Block)();

/*!
 @discussion Class for make assync operations.
 */
@interface AsyncQueue : NSObject
{
    @private
    dispatch_queue_t _queue;
}

/*!
 @discussion Class method that returns a shared singleton instance.
 @return an singleton instance.
 */
+ (id)sharedObject;

/*!
 @discussion This performs the finish block asynchronously.
 Make an async dispatch to GCD (Grand Central Dispatch).
 @see http://developer.apple.com/library/ios/documentation/Performance/Reference/GCD_libdispatch_Ref/Reference/reference.html
 @param block   The block for run asynchronously.
 */
- (void)performAsyncOperation:(Block) block;

@end