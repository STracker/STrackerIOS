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
#import "CommentController.h"

/*!
 @discussion This view show the comment. And if the comment 
 is from the current user, is possible to remove.
 */
@interface CommentViewController : BaseViewController
{
    __weak IBOutlet UILabel *_userName;
    __weak IBOutlet UITextView *_body;
    __weak IBOutlet UIButton *_userProfile;
    
    UIAlertView *_alertDelete;
    Comment *_comment;
    
    CommentController *_commentController;
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