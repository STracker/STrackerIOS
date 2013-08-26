//
//  TvShowCommentsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 09/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowCommentsViewController.h"
#import "TvShow.h"
#import "Comment.h"
#import "CommentsRequests.h"

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
    [CommentsRequests getTvShowComments:_tvshow.identifier finish:^(TvShowComments *obj) {
        
        _comments = obj;
        _data = (NSMutableArray *)obj.comments;
        [_tableView reloadData];
    }];
}

- (void)postComment:(NSString *)comment
{
    [CommentsRequests postTvShowComment:_tvshow.identifier comment:comment finish:^(id obj) {
        
        UIAlertView *alertConfirm = [[UIAlertView alloc] initWithTitle:nil message:@"your comment will be processed..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [alertConfirm show];
    }];
}

@end