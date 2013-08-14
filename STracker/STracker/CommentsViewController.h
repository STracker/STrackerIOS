//
//  CommentsViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "BaseTableViewController.h"
#import "YIPopupTextView.h"

/*!
 @discussion Comments base table. Contains are things 
 that are equal beteween televsion shows comments and 
 episodes comments.
 */
@interface CommentsViewController : BaseTableViewController <YIPopupTextViewDelegate>
{
    UIBarButtonItem *_composeComment;
    NSString *_commentsUri;
}

/*!
 @discussion It's implemented in episodes comments table and
 television comments table for get the comments from STracker.
 */
- (void)getComments;

@end