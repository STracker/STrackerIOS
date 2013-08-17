//
//  UserProfileViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/29/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseProfileViewController.h"

/*!
 @discussion This view controller shows the user's profile options.
 Shows the basic information.
 */
@interface UserProfileViewController : BaseProfileViewController
{
    @private
    __weak IBOutlet UITableViewCell *_inviteCell;
    @private
    Boolean _isFriend;
}

@end