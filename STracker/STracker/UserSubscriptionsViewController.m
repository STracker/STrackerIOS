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
    
}

#pragma mark - BaseViewController abstract methods.

/*!
 @discussion In this case, the data for refreshing is the
 user's subscriptions.
 */
- (void)shakeEvent
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserSubscriptionsURI"];
    
    // Only for take the user object in App.
    [_app getUpdatedUser:^(id obj) {
        
        [UsersController getUserFavoritesTvShows:uri finish:^(id subscriptions) {
            
            User *user = obj;
            user.subscriptions = subscriptions;
            
            // Updating user in App.
            [_app setUser:user];
            
            // Reload data.
            _data = subscriptions;
            [_tableView reloadData];
        }];
    }];
}

@end
