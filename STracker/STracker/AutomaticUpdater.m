//
//  AutomaticUpdater.m
//  STracker
//
//  Created by Ricardo Sousa on 25/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "AutomaticUpdater.h"
#import "AppDelegate.h"
#import "UserInfoManager.h"
#import "CalendarManager.h"
#import "User.h"
#import "UserCalendar.h"

@implementation AutomaticUpdater

// Override init method
- (id)init
{
    if (self = [super init])
        _app = [[UIApplication sharedApplication] delegate];
    
    return self;
}

- (void)startWithInterval:(float)interval
{
    if (interval == 0)
        return;
    
    if (_timer != nil && _timer.timeInterval == interval)
        return;
    
    //Convert to min.
    interval *= 60;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(looper) userInfo:nil repeats:YES];
}

- (void)stop
{
    [_timer invalidate];
    _timer = nil;
}

- (BOOL)check
{
    return _timer != nil;
}

/*!
 @discussion Method that is invoked when is time for getting
 the user information from server.
 */
- (void)looper
{
    [_app.userManager getUser:^(User *oldUser) {
        
        [_app.userManager syncUser:^(User *newUser) {
            
            NSLog(@"debug: automatic update call. -> sync user");
            
            if (oldUser.friendRequests.count < newUser.friendRequests.count)
                [[AppDelegate getAlertViewForErrors:@"New friend request received."] show];
            
            if (oldUser.suggestions.count < newUser.suggestions.count)
                [[AppDelegate getAlertViewForErrors:@"New suggestion received."] show];
        }];
        
        [_app.userManager.calendarManager syncUserCalendar:^(id obj) {
            
            // Nothing todo...
            
            NSLog(@"debug: automatic update call. -> sync calendar");
        }];
    }];
}

@end
