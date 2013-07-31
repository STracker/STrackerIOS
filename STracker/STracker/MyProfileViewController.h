//
//  CurrentUserProfileViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 21/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseProfileViewController.h"
#import "TDBadgedCell.h"

/*!
 @discussion This view controller shows the current user profile options.
 Shows the basic information, plus the calendar, the favorite shows, friends
 and messages.
 */
@interface MyProfileViewController : BaseProfileViewController
{
    __weak IBOutlet TDBadgedCell *_suggestions;
    __weak IBOutlet TDBadgedCell *_requests;
}

@end