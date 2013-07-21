//
//  CurrentUserProfileViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 21/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define BACKGROUND @"BackgroundPattern.png"

/*!
 @discussion This view controller shows the current user profile options.
 Shows the basic information, plus the calendar, the favorite shows, friends
 and messages.
 */
@interface CurrentUserProfileViewController : UITableViewController
{
    AppDelegate *_app;
    User *_user;
    
    __weak IBOutlet UIImageView *_photo;
    __weak IBOutlet UILabel *_name;
}

@end