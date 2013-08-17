//
//  UserSubscriptionsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 01/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "UserSubscriptionsViewController.h"
#import "Subscription.h"
#import "UsersController.h"

@implementation UserSubscriptionsViewController

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    Subscription *subscription = [_data objectAtIndex:indexPath.row];
    
    cell.textLabel.text = subscription.tvshow.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d episodes watched", subscription.episodesWatched.count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO
}

@end
