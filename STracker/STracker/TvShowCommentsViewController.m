//
//  TvShowCommentsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 09/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowCommentsViewController.h"
#import "CommentController.h"

@implementation TvShowCommentsViewController

- (id)initWithTvShow:(TvShow *)tvshow
{
    if (self = [super initWithData:[[NSArray alloc] init]])
        _tvshow = tvshow;
    
    return self;
}

#pragma mark - CommentsViewcontroller abstract methods.

- (void)getComments
{
    // For cache control...
    NSString *version = nil;
    if (_comments != nil)
        version = [NSString stringWithFormat:@"%d", _comments.version];
    
    [CommentController getTvShowComments:_tvshow.identifier withVersion:version finish:^(TvShowComments *obj) {
        
        _comments = obj;
        _data = obj.comments;
        [_tableView reloadData];
    }];
}

- (void)postComment:(NSString *)comment
{
    [CommentController postTvShowComment:_tvshow.identifier comment:comment finish:^(id obj) {
        
        UIAlertView *alertConfirm = [[UIAlertView alloc] initWithTitle:nil message:@"your comment will be processed..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [alertConfirm show];
    }];
}

@end