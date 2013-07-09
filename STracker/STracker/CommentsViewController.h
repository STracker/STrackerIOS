//
//  CommentsViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTableViewController.h"
#import "CommentViewController.h"
#import "Comment.h"
#import "YIPopupTextView.h"
#import "FacebookView.h"
#import "CommentTvShowViewController.h"

@interface CommentsViewController : BaseTableViewController <YIPopupTextViewDelegate>
{
    UIBarButtonItem *_composeComment;
}

// Hook method.
- (void)popupTextViewHook:(YIPopupTextView*)textView didDismissWithText:(NSString*)text cancelled:(BOOL)cancelled;

- (void)openCommentHook:(Comment *)comment;

@end