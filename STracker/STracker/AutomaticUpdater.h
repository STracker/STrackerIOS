//
//  AutomaticUpdater.h
//  STracker
//
//  Created by Ricardo Sousa on 25/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppDelegate;

/*!
 @discussion Class for manage the automatic
 updates.
 */
@interface AutomaticUpdater : NSObject
{
    @private NSTimer *_timer;
    @private AppDelegate *_app;
}

/*!
 @discussion This method starts the timer.
 */
- (void)start;

/*!
 @discussion This method stops the timer.
 */
- (void)stop;

@end