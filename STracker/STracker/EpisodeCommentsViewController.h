//
//  EpisodeCommentsViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/10/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CommentsViewController.h"
#import "Episode.h"

@interface EpisodeCommentsViewController : CommentsViewController
{
    Episode *_episode;
}

// Constructor.
- (id)initWithData:(NSArray *)data andEpisode:(Episode *)episode;

@end