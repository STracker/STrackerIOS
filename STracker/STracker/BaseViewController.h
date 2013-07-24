//
//  BaseViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/22/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define BACKGROUND @"BackgroundPattern.png"

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

@end