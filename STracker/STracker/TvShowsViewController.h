//
//  ShowsViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "STrackerServerHttpClient.h"
#import "TvShow.h"
#import "TvShowViewController.h"

#define BACKGROUND @"BackgroundPattern.png"

@interface TvShowsViewController : BaseTableViewController

- (void)fillTable:(NSDictionary *)data;
- (void)failure:(NSError *)error;

@end