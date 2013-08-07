//
//  CommentViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Comment.h"

/*!
 @discussion This view show the comment. And if the comment 
 is from the current user, is possible to remove.
 */
@interface CommentViewController : BaseViewController
{
    @private
    __weak IBOutlet UITextView *_body;
    @private
    __weak IBOutlet UIButton *_userProfile;
    @private
    __weak IBOutlet UILabel *_userName;
    
    @private
    UIAlertView *_alertDelete;
    @private
    Comment *_comment;
}

/*!
 @discussion Init method for return an instance of 
 CommentViewController.
 Receives one instance of Comment that contains all information about
 the comment.
 @param comment The comment with information.
 @return An instance of CommentViewController.
 */
- (id)initWithComment:(Comment *)comment;

/*!
 @discussion Action for open the comment user's profile.
 */
- (IBAction)openUserProfile;

@end