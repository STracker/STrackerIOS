//
//  EpisodeCommentsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/10/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "EpisodeCommentsViewController.h"
#import "Episode.h"
#import "Comment.h"
#import "CommentsRequests.h"

@implementation EpisodeCommentsViewController

- (id)initWithEpisode:(Episode *)episode
{
    if (self = [super init])
        _episode = episode;
    
    return self;
}

- (void)getComments
{
    [CommentsRequests getEpisodeComments:_episode.identifier finish:^(EpisodeComments *obj) {
        
        _comments = obj;
        _data = (NSMutableArray *)obj.comments;
        [_tableView reloadData];
    }];
}

- (void)postComment:(NSString *)comment
{
    [CommentsRequests postEpisodeComment:_episode.identifier comment:comment finish:^(id obj) {
        
        UIAlertView *alertConfirm = [[UIAlertView alloc] initWithTitle:nil message:@"your comment will be processed..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [alertConfirm show];
    }];
}

@end
