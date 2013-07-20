/*
//
//  ProfileViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 10/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "DownloadFiles.h"
#import "SubscriptionsViewController.h"
#import "UsersViewController.h"

#define BACKGROUND @"BackgroundPattern.png"

@interface ProfileViewController : UIViewController <UIActionSheetDelegate>
{
    __weak IBOutlet UIImageView *_photo;
    __weak IBOutlet UILabel *_numberOfSubscriptions;
}

@property(nonatomic, strong) User *user;

- (IBAction)options:(id)sender;
- (IBAction)invite;

@end
*/