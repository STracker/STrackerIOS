//
//  SubscriptionsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 10/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SubscriptionsViewController.h"


@implementation SubscriptionsViewController

#pragma mark - BaseTableViewController override methods.
- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    Subscription *subscription = [_data objectAtIndex:indexPath.row];
    cell.textLabel.text = subscription.tvshow.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d episodes watched", subscription.episodesWatched.count];
}

- (void)viewDidLoadHook
{
    _numberOfSections = 1;
    self.navigationItem.title = @"Subscriptions";
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Subscription *subscription = [_data objectAtIndex:indexPath.row];
    
    [[STrackerServerHttpClient sharedClient] deleteSubscription:subscription success:^(AFJSONRequestOperation *operation, id result) {
        
        [_data removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        
    } failure:nil];
}

@end
