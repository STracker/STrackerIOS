//
//  FacebookViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 06/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "FacebookView.h"
#import "UIViewController+KNSemiModal.h"
#import "UsersRequests.h"
#import "UserInfoManager.h"
#import "User.h"

@implementation FacebookView

#pragma mark - FacebookView public methods.
- (id)initWithCallback:(Finish) finish
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self = [super initWithFrame:CGRectMake(0, 0, screenBounds.size.width, 60)];
    if (self)
    {
        NSArray *permissions = [NSArray arrayWithObjects:@"email", nil];
        _fb = [[FBLoginView alloc] initWithReadPermissions:permissions];
        [_fb setDelegate:self];
        [self addSubview:_fb];
        [_fb setCenter:self.center];
        _finish = finish;
    }
    
    return self;
}

#pragma mark - FBLoginView delegate
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
        [_fb setHidden:YES];
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error
{
    [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    User *me = [[User alloc] init];
    me.identifier = user.id;
    me.name = user.name;
    me.Email = [user objectForKey:@"email"];
    
    _finish(me);
}

@end