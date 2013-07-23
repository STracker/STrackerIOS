//
//  TvShowCommentsViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 09/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CommentsViewController.h"
#import "TvShow.h"

@interface TvShowCommentsViewController : CommentsViewController
{
    TvShow *_tvshow;
}

// Constructor.
- (id)initWithData:(NSArray *)data andTvShow:(TvShow *)tvshow;

@end