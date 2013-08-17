//
//  BaseProfileViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/29/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "AppDelegate.h"


#define BACKGROUND @"BackgroundPattern2.png"

/*!
 @discussion Base controller for profiles views.
 */
@interface BaseProfileViewController : UITableViewController
{
    AppDelegate *_app;
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

/*!
 @discussion Abstract method, is implemented by sub classes.
 Defines the events that happen after an shake gesture, usually
 the events is for refresh view's data.
 */
- (void)shakeEvent;

/*!
 @discussion This method sets the outlets of user basic information.
 */
- (void)fillUserInformation;

@end