//
//  FacebookViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 06/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "FacebookView.h"
#import "UIViewController+KNSemiModal.h"
#import "STrackerServerHttpClient.h"
#import "AppDelegate.h"

@implementation FacebookView

#pragma mark - FacebookView public methods.
- (id)initWithController:(UIViewController *)controller
{
    // 43 is the heigth of the FBLoginView button.
    self = [super initWithFrame:CGRectMake(0, 0, 0, 43)];
    if (self)
    {
        _app = [[UIApplication sharedApplication] delegate];
        
        _fb = [[FBLoginView alloc] init];
        [_fb setDelegate:self];
        [_fb setCenter:CGPointMake(controller.view.center.x, _fb.center.y)];
        [self addSubview:_fb];
        
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
    [[_app getAlertViewForErrors:error.localizedDescription] show];
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    // Clear information for retrieving the new.
    [FBSession.activeSession closeAndClearTokenInformation];
    
    User *me = [[User alloc] init];
    me.Key = user.id;
    me.Name = user.name;
    me.Photo = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", me.Key];
    
    // TODO
    me.Email = @"test@test.com";
    
    // Set Hawk credentials for authenticated requests to server.
    HawkCredentials *credentials = [[HawkCredentials alloc] init];
    credentials.identifier = me.Key;
    credentials.key = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"HawkKey"];
    [_app setHawkCredentials:credentials];
    
    // Register the user into STracker server.
    
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserURI"];
    
    NSArray *keys = [[NSArray alloc] initWithObjects:@"Email", @"Name", @"Photo", nil];
    NSArray *values = [[NSArray alloc] initWithObjects:me.Email, me.Name, me.Photo, nil];
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    
    [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
        
        // If success set the user object in AppDelegate.
        [_app setUser:me];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
    
    // Dismiss this view.
    [_controller dismissSemiModalView];
}

@end