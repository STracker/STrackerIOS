//
//  EpisodeCommentsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/10/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "EpisodeCommentsViewController.h"

@implementation EpisodeCommentsViewController

- (id)initWithEpisode:(Episode *)episode
{
    if (self = [super init])
    {
        _episode = episode;
        
        // Set uri for this episodes comments.
        _commentsUri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerEpisodeCommentsURI"];
        _commentsUri = [_commentsUri stringByReplacingOccurrencesOfString:@"tvshowId" withString:_episode.tvshowId];
        _commentsUri = [_commentsUri stringByReplacingOccurrencesOfString:@"seasonNumber" withString:[NSString stringWithFormat:@"%@", _episode.seasonNumber]];
        _commentsUri = [_commentsUri stringByReplacingOccurrencesOfString:@"episodeNumber" withString:[NSString stringWithFormat:@"%@", _episode.episodeNumber]];
    }
    
    
    return self;
}

@end
