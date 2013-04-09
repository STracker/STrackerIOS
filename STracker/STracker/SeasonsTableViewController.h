//
//  SeasonsTableViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 09/04/13.
//  Copyright (c) 2013 Ricardo Sousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Season.h"
#import "Episode.h"
#import "EpisodeTableViewController.h"

@interface SeasonsTableViewController : UITableViewController

@property(nonatomic, retain) NSMutableArray *Seasons;

@end
