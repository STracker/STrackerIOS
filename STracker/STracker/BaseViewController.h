//
//  BaseViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/22/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

//#define BACKGROUND @"BackgroundPattern.png"

/*!
 @discussion This controller is the base controller of all 
 view controllers. Contains the AppDelegate instance for using 
 by the sub-controllers, and redefine the background color pattern
 in viewDidLoad method.
 */
@interface BaseViewController : UIViewController
{
    AppDelegate *_app;
}

/*!
 @discussion Abstract method, is implemented by sub classes. 
 Defines the events that happen after an shake gesture, usually 
 the events is for refresh view's data.
 */
- (void)shakeEvent;

@end