//
//  EpisodeCommentsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/10/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "EpisodeCommentsViewController.h"
#import "CommentController.h"
#import "Comment.h"

@implementation EpisodeCommentsViewController

- (id)initWithEpisode:(Episode *)episode
{
    if (self = [super init])
    {
        _episode = episode;
        
        // Set uri for this episodes comments.
        _commentsUri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerEpisodeCommentsURI"];
        _commentsUri = [_commentsUri stringByReplacingOccurrencesOfString:@"tvshowId" withString:_episode.identifier.tvshowId];
        _commentsUri = [_commentsUri stringByReplacingOccurrencesOfString:@"seasonNumber" withString:[NSString stringWithFormat:@"%d", _episode.identifier.seasonNumber]];
        _commentsUri = [_commentsUri stringByReplacingOccurrencesOfString:@"episodeNumber" withString:[NSString stringWithFormat:@"%d", _episode.identifier.episodeNumber]];
    }
    
    
    return self;
}

- (void)getComments
{
    [CommentController getEpisodeComments:_commentsUri finish:^(EpisodeComments *obj) {
       
        _data = obj.comments;
        [_tableView reloadData];
    }];
}

@end
