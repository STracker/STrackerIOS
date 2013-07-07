//
//  FacebookViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 06/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "FacebookView.h"

@implementation FacebookView

- (id)initWithController:(UIViewController *)controller
{
    // 43 is the heigth of the FBLoginView button.
    self = [super initWithFrame:CGRectMake(0, 0, 0, 43)];
    if (self)
    {
        _fb = [[FBLoginView alloc] init];
        [_fb setDelegate:self];
        
        [_fb setCenter:CGPointMake(controller.view.center.x, _fb.center.y)];
        [self addSubview:_fb];
        
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_indicator setColor:[UIColor whiteColor]];
        [self addSubview:_indicator];
        
        _app = [[UIApplication sharedApplication] delegate];
        _controller = controller;
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
    NSLog(@"error: %@", error.localizedDescription);
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    // Clear information for retrieving the new.
    [FBSession.activeSession closeAndClearTokenInformation];
    
    User *me = [[User alloc] init];
    me.identifier = user.id;
    me.name = user.name;  
    
    // Create the user in application.
    _app.user = me;
    
    // Dismiss this view.
    [_controller dismissSemiModalView];
}

@end