/*
//
//  ProfileViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 10/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "User.h"

@interface ProfileViewController : BaseViewController <UIActionSheetDelegate>
{
    __weak IBOutlet UIImageView *_photo;
    __weak IBOutlet UILabel *_numberOfSubscriptions;
    
    User *_user;
}

- (id)initWithUser:(User *)user;

- (IBAction)options:(id)sender;
- (IBAction)invite;

@end
*/