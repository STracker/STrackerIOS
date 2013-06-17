//
//  SeasonViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "BaseTableViewController.h"
#import "Episode.h"
#import "STrackerServerHttpClient.h"
#import "EpisodeViewController.h"

@interface SeasonViewController : BaseTableViewController

@property(nonatomic, copy) NSString *title;

@end
