//
//  UserProfileViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/29/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UsersViewController.h"
#import "UsersRequests.h"
#import "SubscriptionsViewController.h"
#import "User.h"
#import "UserInfoManager.h"

@implementation UserProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_app.userManager getUser:^(User *me) {
        
        // Verify if this user is already friend of the current user.
        if ([_user.friends objectForKey:me.identifier] != nil)
        {
            _inviteCell.textLabel.text = @"Remove friend";
            _isFriend = YES;
        }
        
        // Verify if this user sends a friend request to current user.
        if ([me.friendRequests objectForKey:_user.identifier] != nil)
        {
            _inviteCell.textLabel.text = @"Response to friend request";
            _invitedMe = YES;
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
            [self inviteOrRemoveOrAccept];
            break;
    }
}

#pragma mark - UIAlert View delegates.

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
        [self acceptInvite];
    else
        [self rejecttInvite];
    
    [alertView setDelegate:nil];
    alertView = nil;
}

#pragma mark - shake gesture.

- (void)shakeEvent
{
    // Need to construct the uri because the user don't have the uri, only the identifier.
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUsersURI"];
    uri = [uri stringByAppendingFormat:@"/%@", _user.identifier];
    
    [UsersRequests getUser:uri finish:^(id obj) {
        
        _user = obj;
        
        // Update userInformation.
        [super fillUserInformation];
    }];
}

#pragma mark - UserProfileViewController private auxiliary methods. Note: the next methods have a diferent implementation than the MyProfileViewController.

/*!
 @discussion This method opens a table with user's subscriptions.
 */
- (void)subscriptions
{
    SubscriptionsViewController *view = [[SubscriptionsViewController alloc] initWithData:_user.subscriptions.allValues andTitle:@"Subscriptions"];
    
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
 @discussion This method invite/delete this user as a friend, or accept the user as a friend if the user 
 sends an friend request.
 */
- (void)inviteOrRemoveOrAccept
{
    if (_invitedMe)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request" message:@"You accept this user as a friend?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        
        [alert show];
        return;
    }
    
    // Add friend.
    if (!_isFriend)
    {
        [UsersRequests inviteUser:_user finish:^(id obj) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The invitation request has been sent successfully." message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
            [alert show];
        }];
        
        return;
    }
    
    // Remove friend.
    [UsersRequests deleteFriend:_user.identifier finish:^(id obj) {
        
        _isFriend = NO;
        _inviteCell.textLabel.text = @"Add friend";
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Friend removed." message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
        
        // Update local information.
        [_app.userManager getUser:^(User *user) {
            
            [user.friends removeObjectForKey:_user.identifier];
            [_app.userManager updateUser:user];
        }];
    }];
}

/*!
 @discussion Auxiliary method for accept this user invitation to become user's friend.
 */
- (void)acceptInvite
{
    [UsersRequests acceptFriendRequest:_user.identifier finish:^(id obj) {
        
        _invitedMe = NO;
        _isFriend = YES;
        _inviteCell.textLabel.text = @"Remove friend";
        
        // Update local information.
        [_app.userManager getUser:^(User *user) {
            
            [user.friendRequests removeObjectForKey:_user.identifier];
            [user.friends setValue:[_user getSynopsis] forKey:_user.identifier];
            
            [_app.userManager updateUser:user];
        }];
    }];
}

/*!
 @discussion Auxiliary method for reject this user invitation to become user's friend.
 */
- (void)rejecttInvite
{
    [UsersRequests rejectFriendRequest:_user.identifier finish:^(id obj) {
        
        _invitedMe = NO;
        _isFriend = NO;
        _inviteCell.textLabel.text = @"Add friend";
        
        // Update local information.
        [_app.userManager getUser:^(User *user) {
            
            [user.friendRequests removeObjectForKey:_user.identifier];
            [_app.userManager updateUser:user];
        }];
    }];
}
@end