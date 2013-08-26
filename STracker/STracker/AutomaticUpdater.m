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
#import "User.h"

@implementation AutomaticUpdater

// Override init method
- (id)init
{
    if (self = [super init])
        _app = [[UIApplication sharedApplication] delegate];
    
    return self;
}

- (void)start
{
    if (_timer != nil)
        return;
    
    // TODO -> put the seconds in users defaults.
    _timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(selector) userInfo:nil repeats:YES];
}

- (void)stop
{
    [_timer invalidate];
    _timer = nil;
}

/*!
 @discussion Method that is invoked when is time for getting
 the user information from server.
 */
- (void)seletor
{
    NSLog(@"debug: automatic update call.");
    
    [_app.userManager getUser:^(User *oldUser) {
        
        [_app.userManager syncUser:^(User *newUser) {
            
            if (oldUser.friendRequests.count < newUser.friendRequests.count)
                [[AppDelegate getAlertViewForErrors:@"New friend request received."] show];
            
            if (oldUser.suggestions.count < newUser.suggestions.count)
                [[AppDelegate getAlertViewForErrors:@"New suggestion received."] show];
        }];
    }];
}

@end
