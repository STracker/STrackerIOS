//
//  ShowsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowsViewController.h"
#import "TvShowsController.h"
#import "TvShow.h"
#import "TvShowViewController.h"

@implementation TvShowsViewController

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
    
    [TvShowsController getTvShowsByName:_tableTitle withRange:range finish:^(id obj) {
        
        NSMutableArray *tvshows = [[NSMutableArray alloc] initWithArray:_data];
        [tvshows addObjectsFromArray:obj];
        
        // reload table for show the new television shows.
        _data = tvshows;
        [_tableView reloadData];
    }];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Open a particular tvshow controller...
    TvShowSynopsis *synopse = [_data objectAtIndex:indexPath.row];    
    [TvShowsController getTvShow:synopse.uri finish:^(id obj) {
        
        TvShowViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"TvShowView"] initWithTvShow:obj];
        [self.navigationController pushViewController:view animated:YES];
    }];
}

@end