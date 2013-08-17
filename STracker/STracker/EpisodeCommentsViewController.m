//
//  EpisodeCommentsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/10/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "EpisodeCommentsViewController.h"
#import "CommentController.h"

@implementation EpisodeCommentsViewController

- (id)initWithEpisode:(Episode *)episode
{
    if (self = [super init])
        _episode = episode;
    
    return self;
}

- (void)getComments
{
    // For cache control...
    NSString *version = nil;
    if (_comments != nil)
        version = [NSString stringWithFormat:@"%d", _comments.version];
    
    [CommentController getEpisodeComments:_episode.identifier finish:^(EpisodeComments *obj) {
        
        _comments = obj;
        _data = obj.comments;
        [_tableView reloadData];
    }];
}

@end
