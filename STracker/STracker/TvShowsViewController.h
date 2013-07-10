//
//  ShowsViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "STrackerServerHttpClient.h"
#import "BaseTableViewController.h"
#import "TvShowViewController.h"
#import "TvShow.h"

@interface TvShowsViewController : BaseTableViewController
{
    NSString *_tableTitle;
}

// Init method that receives the data and the name of the title.
- (id)initWithData:(NSMutableArray *)data andTitle:(NSString *)title;

@end