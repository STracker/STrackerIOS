//
//  UsersInformationTests.m
//  STracker
//
//  Created by Ricardo Sousa on 10/09/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "UsersInformationTests.h"
#import "AppDelegate.h"
#import "UserInfoManager.h"
#import "User.h"
#import "UsersRequests.h"

@implementation UsersInformationTests

/*!
 @discussion Get the current user (Ricardo Sousa - me :)) from 
 DB. Must be logged in to do this.
 */
- (void) testGetMe
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.userManager getUser:^(User *me) {
        
        STAssertEqualObjects(me.identifier, @"100000004098766", @"my identifier");
        STAssertEqualObjects(me.name, @"Ricardo Sousa", @"my name");
        STAssertEqualObjects(me.email, @"r.sousa8@live.com.pt", @"my email");
    }];
}

/*!
 @discussion Get other user.
 */
- (void) testGetUser
{
    __block BOOL done = NO;
    __block User *user;
    
    NSString *uri = @"users/100001194244053";
    [UsersRequests getUser:uri finish:^(id obj) {
        user = obj;
        done = YES;
    }];
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:30];
    while (!done && [loopUntil timeIntervalSinceNow] > 0)
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:loopUntil];
    
    if (done)
    {
        STAssertEqualObjects(user.identifier, @"100001194244053", @"user identifier");
        STAssertEqualObjects(user.name, @"Diogo Matos", @"user name");
        STAssertEqualObjects(user.email, @"diogoscp_forever@hotmail.com", @"user email");
    }
}

@end
