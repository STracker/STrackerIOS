//
//  UserProfileViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/29/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UsersViewController.h"
#import "AppDelegate.h"
#import "UsersController.h"

@implementation UserProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    // Already loged in in this moment, so only retrieves the current user information.
    [app getUpdatedUser:^(id obj) {
        
        User *me = obj;
        
        // Verify if this user is already friend of the current user.
        for (UserSynopsis *synopse in _user.friends)
        {
            if ([synopse.identifier isEqualToString:me.identifier])
            {
                _inviteCell.textLabel.text = @"Remove friend";
                _isFriend = YES;
                break;
            }
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
    //TODO
}

/*!
 @discussion This method opens a table with user's friends.
 */
- (void)friends
{
    UsersViewController *view = [[UsersViewController alloc] initWithData:_user.friends andTitle:@"Friends"];
    
    [self.navigationController pushViewController:view animated:YES];
}

/*!
 @discussion This method invite or delete this user as a friend.
 */
- (void)inviteOrRemove
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserFriendsURI"];
   
    // Add friend.
    if (!_isFriend)
    {
        [UsersController inviteUser:uri withUser:_user finish:^(id obj) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The invitation request has been sent successfully." message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
            [alert show];
        }];
        
        return;
    }
    
    // Remove friend.
    uri = [uri stringByAppendingFormat:@"/%@", _user.identifier];
    
    [UsersController deleteFriend:uri finish:^(id obj) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Friend removed." message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
    }];
}

@end