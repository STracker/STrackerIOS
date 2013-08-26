//
//  SubscriptionsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 8/23/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SubscriptionsViewController.h"
#import "Subscription.h"
#import "TvShow.h"
#import "SubscriptionViewController.h"

@implementation SubscriptionsViewController

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    Subscription *subscription = [_data objectAtIndex:indexPath.row];
    
    cell.textLabel.text = subscription.tvshow.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d episode(s) watched", subscription.episodesWatched.count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Subscription *sub = [_data objectAtIndex:indexPath.row];
    
    SubscriptionViewController *view = [[SubscriptionViewController alloc] initWithSubscription:sub];
    [self.navigationController pushViewController:view animated:YES];
}

@end
