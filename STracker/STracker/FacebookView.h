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

/*!
 @discussion This view allows the user to Login into Facebook.
 */
@interface FacebookView : UIView<FBLoginViewDelegate>
{
    AppDelegate *_app;
    Finish _finish;
    FBLoginView *_fb;
}

/*!
 @discussion Init method that receives the callback for execute code after the login.
 @param finish The finish callback.
 @return One instance of FacebookView.
 */
- (id)initWithCallback:(Finish) finish;

@end