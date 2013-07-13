//
//  OptionsViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 24/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "FacebookView.h"
#import "SubscriptionsViewController.h"
#import "UsersViewController.h"
#import "DownloadFiles.h"

#define BACKGROUND @"BackgroundPattern.png"

@interface OptionsViewController : UITableViewController
{
    AppDelegate *_app;
    __weak IBOutlet UITableViewCell *_profileCell;
    __weak IBOutlet UIImageView *_profilePhoto;
    __weak IBOutlet UILabel *_profileName;
}

@end
