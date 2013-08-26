//
//  SearchResultsTvShowsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 22/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SearchResultsTvShowsViewController.h"
#import "TvShowsRequests.h"
#import "Range.h"

@implementation SearchResultsTvShowsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIBarButtonItem *bt = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(moreTvShows)];
    
    [self.navigationItem setRightBarButtonItem:bt animated:YES];
}

- (void)moreTvShows
{
    Range *range = [[Range alloc] init];
    range.start = [_data count];
    range.end = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerElemsPerSearch"] intValue] + [_data count];
    
    [TvShowsRequests getTvShowsByName:_tableTitle withRange:range finish:^(id obj) {
        
        NSMutableArray *tvshows = [[NSMutableArray alloc] initWithArray:_data];
        [tvshows addObjectsFromArray:obj];
        
        // reload table for show the new television shows.
        _data = tvshows;
        [_tableView reloadData];
    }];
}

@end
