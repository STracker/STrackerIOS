//
//  TvShowCommentsViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 09/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CommentsViewController.h"

@class TvShow;
@class TvShowComments;

/*!
 @discussion Table of television shows comments.
 */
@interface TvShowCommentsViewController : CommentsViewController
{
    @private TvShow *_tvshow;
    @private TvShowComments *_comments;
}

/*!
 @discussion Init method for create the table view controller.
 @param tvshow The television show object with information.
 @return An instance of TvShowCommentsViewController.
 */
- (id)initWithTvShow:(TvShow *)tvshow;

@end