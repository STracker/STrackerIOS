//
//  CommentsViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "BaseTableViewController.h"
#import "YIPopupTextView.h"

@interface CommentsViewController : BaseTableViewController <YIPopupTextViewDelegate>
{
    UIBarButtonItem *_composeComment;
}

- (void)popupTextViewHook:(NSString *)text;

@end