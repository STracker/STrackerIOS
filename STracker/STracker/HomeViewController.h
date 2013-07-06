//
//  CalendarViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 24/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "GenresViewController.h"
#import "STrackerServerHttpClient.h"
#import "Genre.h"
#import "TvShow.h"
#import "TvShowsViewController.h"
#import "FacebookViewController.h"

@interface HomeViewController : BaseTableViewController <UIActionSheetDelegate, UIAlertViewDelegate>

- (id)init;
- (IBAction)searchOptions:(UIBarButtonItem *)sender;

@end