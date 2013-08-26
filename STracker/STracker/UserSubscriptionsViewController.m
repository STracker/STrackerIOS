//
//  UserSubscriptionsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 01/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "UserSubscriptionsViewController.h"
#import "Subscription.h"
#import "UsersRequests.h"
#import "SubscriptionViewController.h"
#import "UserInfoManager.h"
#import "User.h"
#import "TvShow.h"

@implementation UserSubscriptionsViewController

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    Subscription *subscription = [_data objectAtIndex:indexPath.row];
    
    cell.textLabel.text = subscription.tvshow.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d episode(s) watched", subscription.episodesWatched.count];
}

- (void)deleteHookForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Subscription *subscription = [_data objectAtIndex:indexPath.row];
    
    [_data removeObjectAtIndex:indexPath.row];
    
    [UsersRequests deleteSubscription:subscription.tvshow.identifier finish:^(id obj) {
        
        // Update local information.
        [_app.userManager getUser:^(User *user) {
            
            // Remove from user's information in memory.
            [user.subscriptions removeObjectForKey:subscription.tvshow.identifier];
            
            [_app.userManager updateUser:user];
        }];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Subscription *sub = [_data objectAtIndex:indexPath.row];
    
    SubscriptionViewController *view = [[SubscriptionViewController alloc] initWithSubscription:sub];
    [self.navigationController pushViewController:view animated:YES];
}

@end
