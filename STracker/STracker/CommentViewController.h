//
//  CommentViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STrackerServerHttpClient.h"
#import "Comment.h"

#define BACKGROUND @"BackgroundPattern.png"

@interface CommentViewController : UIViewController
{
    __weak IBOutlet UILabel *_userName;
    __weak IBOutlet UITextView *_body;
}

@property(nonatomic, strong) Comment *comment;

@end
