//
//  FriendsRequestsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 01/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "FriendsRequestsViewController.h"
#import "UsersController.h"

@implementation FriendsRequestsViewController


#pragma mark - BaseViewController abstract methods.

/*!
 @discussion In this case, the data for refreshing is the
 user's friends.
 */
- (void)shakeEvent
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserFriendRequestsURI"];
    
    // Only for take the user object in App.
    [_app getUpdatedUser:^(id obj) {
        
        [UsersController getFriendsRequests:uri finish:^(id requests) {
            
            User *user = obj;
            user.friendRequests = requests;
            
            // Updating user in App.
            [_app setUser:user];
            
            // Reload data.
            _data = requests;
            [_tableView reloadData];
        }];
    }];
}

@end
