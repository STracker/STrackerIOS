//
//  ShowsViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoDownloadManager.h"
#import "TvShow.h"

#define BACKGROUND @"BackgroundPattern.png"

@interface ShowsViewController : UITableViewController
{
    NSMutableArray *_tvshows;
}

@property(nonatomic, retain) NSString *genre;

@end
