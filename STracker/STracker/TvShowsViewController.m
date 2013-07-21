//
//  ShowsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowsViewController.h"
#import "STrackerServerHttpClient.h"
#import "TvShow.h"

@implementation TvShowsViewController

#pragma mark - BaseTableViewController override methods.

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    TvShowSynopse *synopse = [_data objectAtIndex:indexPath.row];
    cell.textLabel.text = synopse.name;
}

- (void)viewDidLoadHook
{
    [[STrackerServerHttpClient sharedClient] getRequest:_synopse.uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        _data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            TvShowSynopse *tvshow = [[TvShowSynopse alloc] initWithDictionary:item];
            [_data addObject:tvshow];
        }
        
        // Reload data of table view.
        [self.tableView reloadData];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO.
}

@end