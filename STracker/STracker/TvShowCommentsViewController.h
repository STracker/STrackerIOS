//
//  TvShowCommentsViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 09/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CommentsViewController.h"
#import "STrackerServerHttpClient.h"
#import "CommentViewController.h"

@interface TvShowCommentsViewController : CommentsViewController
{
    TvShow *_tvshow;
}

// Constructor.
- (id)initWithTvShow:(TvShow *)tvshow;

@end
