//
//  CurrentUserProfileViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 21/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "MyProfileViewController.h"
#import "UsersController.h"
#import "UsersViewController.h"

@implementation MyProfileViewController

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 1:
            [self calendar];
            break;
        case 2:
            [self subscriptions];
            break;
        case 3:
            [self friends];
            break;
        case 4:
            [self messages];
            break;
    }
}

#pragma mark - MyProfileViewController private auxiliary methods.

/*!
 @discussion This method opens a table with the calendar of next episodes from user's 
 favorite shows.
 */
- (void)calendar
{
    //TODO
}

/*!
 @discussion This method opens a table with user's messages.
 */
- (void)messages
{
    //TODO
}

/*!
 @discussion This method opens a table with user's subscriptions.
 */
- (void)subscriptions
{
    //TODO
}

/*!
 @discussion This method opens a table with user's friends.
 */
- (void)friends
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserFriendsURI"];
    [[UsersController sharedObject] getFriends:uri finish:^(id obj) {
        
        UsersViewController *view = [[UsersViewController alloc] initWithData:obj andTitle:@"Friends"];
        
        [self.navigationController pushViewController:view animated:YES];
    }];
}

@end
