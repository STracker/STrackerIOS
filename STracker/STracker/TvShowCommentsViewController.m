//
//  TvShowCommentsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 09/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowCommentsViewController.h"

@implementation TvShowCommentsViewController

- (id)initWithData:(NSMutableArray *)data andTvShow:(TvShow *)tvshow
{
    if (self = [super initWithData:data])
        _tvshow = tvshow;
    
    return self;
}

#pragma mark - Hook methods.
- (void)popupTextViewHook:(YIPopupTextView*)textView didDismissWithText:(NSString*)text cancelled:(BOOL)cancelled
{
    [[STrackerServerHttpClient sharedClient] postTvShowComment:_tvshow comment:text success:^(AFJSONRequestOperation *operation, id result) {
    
        //Nothing to do...
    } failure:nil];
}

- (void)openCommentHook:(Comment *)comment
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    CommentTvShowViewController *view = [app.storyboard instantiateViewControllerWithIdentifier:@"CommentTvShow"];
    
    view.comment = comment;
    view.tvshow = _tvshow;
    
    [self.navigationController pushViewController:view animated:YES];
}

@end
