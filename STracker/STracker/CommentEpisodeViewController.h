//
//  CommentEpisodeViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 09/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CommentViewController.h"
#import "STrackerServerHttpClient.h"

@interface CommentEpisodeViewController : CommentViewController

@property(nonatomic, strong) Episode *episode;

@end
