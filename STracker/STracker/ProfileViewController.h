//
//  ProfileViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 07/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define BACKGROUND @"BackgroundPattern.png"

@interface ProfileViewController : UIViewController
{
    __weak IBOutlet UILabel *name;
    __weak IBOutlet UIImageView *photo;
    
    AppDelegate *_app;
}

@end
