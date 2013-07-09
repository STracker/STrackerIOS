//
//  CommentTvShowViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 09/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CommentTvShowViewController.h"

@implementation CommentTvShowViewController

@synthesize tvshow;

#pragma mark - Hook methods.
- (void)deleteCommentHook
{
    [[STrackerServerHttpClient sharedClient] deleteTvShowComment:tvshow comment:self.comment success:^(AFJSONRequestOperation *operation, id result) {
        
        // Go back...
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:nil];
}

@end
