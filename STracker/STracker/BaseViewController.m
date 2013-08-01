//
//  BaseViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/22/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Redefine the background pattern color.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    
    _app = [[UIApplication sharedApplication] delegate];
}

#pragma mark - Shake gesture. 

- (void)shakeEvent
{
    // Not raise exception this time because some controls don't need this feature.
    // [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

/*!
 @discussion Use montion events.
 @see http://developer.apple.com/library/ios/#documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/motion_event_basics/motion_event_basics.html
 */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // if the motion is the shake gesture, invoke shakeEvent method.
    if (motion == UIEventSubtypeMotionShake)
        [self shakeEvent];
}

@end