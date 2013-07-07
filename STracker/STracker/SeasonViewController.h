//
//  SeasonViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "STrackerServerHttpClient.h"
#import "BaseTableViewController.h"
#import "EpisodeViewController.h"
#import "Episode.h"

@interface SeasonViewController : BaseTableViewController
{
    NSString *title;
}

- (id)initWithData:(NSMutableArray *)data andSeasonNumber:(NSString *)seasonNumber;

@end
