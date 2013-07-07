//
//  CalendarViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 24/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "FacebookView.h"
#import "UIViewController+KNSemiModal.h"
#import "STrackerServerHttpClient.h"
#import "OptionsViewController.h"
#import "BaseTableViewController.h"
#import "GenresViewController.h"
#import "TvShowsViewController.h"
#import "Genre.h"
#import "TvShow.h"

#import "SlideshowViewController.h"

@interface HomeViewController : BaseTableViewController <UIActionSheetDelegate, UIAlertViewDelegate>
{
    AppDelegate *_app;
}

- (IBAction)searchOptions:(UIBarButtonItem *)sender;

- (IBAction)userOptions:(id)sender;

@end