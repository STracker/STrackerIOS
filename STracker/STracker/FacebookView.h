//
//  FacebookViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 06/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import "UIViewController+KNSemiModal.h"
#import "STrackerServerHttpClient.h"

@interface FacebookView : UIView<FBLoginViewDelegate>
{
    AppDelegate *_app;
    UIViewController *_controller;
    UIActivityIndicatorView *_indicator;
    FBLoginView *_fb;
}

// Init method that receives the controller for dismiss
// this view after the login.
- (id)initWithController:(UIViewController *)controller;

@end