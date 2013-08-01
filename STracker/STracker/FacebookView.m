//
//  FacebookViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 06/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "FacebookView.h"
#import "UIViewController+KNSemiModal.h"
#import "UsersController.h"

@implementation FacebookView

#pragma mark - FacebookView public methods.
- (id)initWithCallback:(Finish) finish
{
    // 43 is the heigth of the FBLoginView button.
    self = [super initWithFrame:CGRectMake(0, 0, 0, 43)];
    if (self)
    {
        _app = [[UIApplication sharedApplication] delegate]; 
        
        _fb = [[FBLoginView alloc] initWithReadPermissions:[NSArray arrayWithObject:@"email"]];
        [_fb setDelegate:self];
        [self addSubview:_fb];
        
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
    [[_app getAlertViewForErrors:error.localizedDescription] show];
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    // Clear information for retrieving the new.
    [FBSession.activeSession closeAndClearTokenInformation];
    
    User *me = [[User alloc] init];
    me.identifier = user.id;
    me.name = user.name;
    me.photoUrl = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", me.identifier];
    
    // TODO
    me.Email = @"test@test.com";
    
    // Set Hawk credentials for authenticated requests to server.
    HawkCredentials *credentials = [[HawkCredentials alloc] init];
    credentials.identifier = me.identifier;
    credentials.key = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"HawkKey"];
    _app.hawkCredentials = credentials;
    
    // Register the user into STracker server.
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUsersURI"];
    [[UsersController sharedObject] registUser:uri withUser:me finish:^(id obj) {
        
        // If success, execute callback.
        _finish(obj);
    }];
}

@end