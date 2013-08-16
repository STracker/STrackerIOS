//
//  FriendsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 01/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "FriendsViewController.h"
#import "UsersController.h"

@implementation FriendsViewController

#pragma mark - BaseViewController abstract methods.

/*!
 @discussion In this case, the data for refreshing is the
 user's friends.
 */
- (void)shakeEvent
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserFriendsURI"];
    
    // Only for take the user object in App.
    [_app getUpdatedUser:^(id obj) {
        
        [UsersController getFriends:uri finish:^(id friends) {
            
            User *user = obj;
            user.friends = friends;
            
            // Updating user in App.
            [_app setUser:user];
            
            // Reload data.
            _data = friends;
            [_tableView reloadData];
        }];
    }];
}

@end
