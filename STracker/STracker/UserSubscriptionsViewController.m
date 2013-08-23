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

- (void)deleteHookForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Subscription *subscription = [_data objectAtIndex:indexPath.row];
    
    [_data removeObjectAtIndex:indexPath.row];
    
    [UsersController deleteSubscription:subscription.tvshow.identifier finish:^(id obj) {
        
        /*
         Remove subscription from user in memory and update the user in DB.
         */
        [_app getUser:^(User *me) {
            
            // Remove from user's information in memory.
            [me.subscriptions removeObjectForKey:subscription.tvshow.identifier];
            
            // Increment version for cache purposes.
            me.version++;
            
            // Update in DB.
            [_app.dbController updateAsync:me];
        }];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO
}

@end
