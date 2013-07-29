//
//  BaseProfileViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/29/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

#define BACKGROUND @"BackgroundPattern2.png"

/*!
 @discussion Base controller for profiles views.
 */
@interface BaseProfileViewController : UITableViewController
{
    User *_user;
    
    __weak IBOutlet UIImageView *_photo;
    __weak IBOutlet UILabel *_name;
}

/*!
 @discussion Init method that receives an user.
 @param user The user information.
 @return An instance of BaseProfileViewController.
 */
- (id)initWithUserInfo:(User *)user;

@end