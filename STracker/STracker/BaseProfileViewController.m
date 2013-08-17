//
//  BaseProfileViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/29/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "BaseProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@implementation BaseProfileViewController

/*
 This method don't call the [super init], because this controller
 is instanced from storyboard.
 */
- (id)initWithUserInfo:(User *)user
{
    _user = user;
    _app = [[UIApplication sharedApplication] delegate];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self fillUserInformation];
}

- (void)viewDidUnload
{
    _photo = nil;
    _name = nil;
    
    [super viewDidUnload];
}

- (void)fillUserInformation
{
    // Set properties of basic user information.
    _name.text = _user.name;
    
    [_photo setImageWithURL:[NSURL URLWithString:_user.photoUrl]];
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