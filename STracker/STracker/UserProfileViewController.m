//
//  UserProfileViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/29/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UsersViewController.h"
#import "UsersController.h"
#import "UserSubscriptionsViewController.h"

@implementation UserProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Already loged in in this moment, so only retrieves the current user information.
    [_app getUser:^(User *me) {
        
        // Verify if this user is already friend of the current user.
        if ([_user.friends objectForKey:me.identifier] != nil)
        {
            _inviteCell.textLabel.text = @"Remove friend";
            _isFriend = YES;
        }
    }];
}

- (void)viewDidUnload
{
    _inviteCell = nil;
    
    [super viewDidUnload];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 1:
            [self subscriptions];
            break;
        case 2:
            [self friends];
            break;
        case 3:
            [self inviteOrRemove];
            break;
    }
}

#pragma mark - UserProfileViewController private auxiliary methods. Note: the next methods have a diferent implementation than the MyProfileViewController.

/*!
 @discussion This method opens a table with user's subscriptions.
 */
- (void)subscriptions
{
    UserSubscriptionsViewController *view = [[UserSubscriptionsViewController alloc] initWithData:_user.subscriptions.allValues andTitle:@"Subscriptions"];
    
    [self.navigationController pushViewController:view animated:YES];
}

/*!
 @discussion This method opens a table with user's friends.
 */
- (void)friends
{
    UsersViewController *view = [[UsersViewController alloc] initWithData:_user.friends.allValues andTitle:@"Friends"];
    
    [self.navigationController pushViewController:view animated:YES];
}

/*!
 @discussion This method invite or delete this user as a friend.
 */
- (void)inviteOrRemove
{
    // Add friend.
    if (!_isFriend)
    {
        [UsersController inviteUser:_user finish:^(id obj) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The invitation request has been sent successfully." message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
            [alert show];
        }];
        
        return;
    }
    
    // Remove friend.
    [UsersController deleteFriend:_user.identifier finish:^(id obj) {
        
        _isFriend = NO;
        _inviteCell.textLabel.text = @"Add friend";
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Friend removed." message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
    }];
    
    
}

@end