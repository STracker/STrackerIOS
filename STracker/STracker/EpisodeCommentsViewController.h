//
//  EpisodeCommentsViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/10/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CommentsViewController.h"
#import "Episode.h"

/*!
 @discussion Table view for episodes comments.
 */
@interface EpisodeCommentsViewController : CommentsViewController
{
    Episode *_episode;
}

/*!
 @discussion Init method for create the table view controller.
 @param episode The episode object with information.
 @return An instance of EpisodeCommentsViewController.
 */
- (id)initWithEpisode:(Episode *)episode;

@end