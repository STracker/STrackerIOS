//
//  CommentTvShowViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 09/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CommentViewController.h"
#import "STrackerServerHttpClient.h"

@interface CommentTvShowViewController : CommentViewController

@property(nonatomic, strong) TvShow *tvshow;

@end
