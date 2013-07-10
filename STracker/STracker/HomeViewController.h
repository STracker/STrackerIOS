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
#import "KIImagePager.h"
#import "STrackerServerHttpClient.h"
#import "OptionsViewController.h"
#import "BaseTableViewController.h"
#import "GenresViewController.h"
#import "TvShowsViewController.h"
#import "Genre.h"
#import "TvShow.h"

@interface HomeViewController : UIViewController <KIImagePagerDelegate, KIImagePagerDataSource, UIActionSheetDelegate, UIAlertViewDelegate>
{
    __weak IBOutlet KIImagePager *imagePager;
    NSMutableArray *_top;
    AppDelegate *_app;
}

- (IBAction)searchOptions:(UIBarButtonItem *)sender;

- (IBAction)userOptions:(id)sender;

@end