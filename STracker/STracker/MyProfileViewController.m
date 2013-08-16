//
//  CurrentUserProfileViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 21/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "MyProfileViewController.h"
#import "UsersController.h"
#import "SuggestionsViewController.h"
#import "UserSubscriptionsViewController.h"
#import "UsersViewController.h"

@implementation MyProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setBadgesInfo];
}

- (void)viewDidUnload
{
    _suggestions = nil;
    _requests = nil;
    [super viewDidUnload];
}

#pragma mark - BaseViewController abstract methods.

/*!
 @discussion In this case, the data for refreshing is the 
 user information. So its needed in the end to set user 
 information in App.
 */
- (void)shakeEvent
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUsersURI"];
    uri = [uri stringByAppendingString:[NSString stringWithFormat:@"/%@", _user.identifier]];
    
    [_app getUser:^(id obj) {
        
        _user = obj;
        
        // Update userInformation.
        [super fillUserInformation];
        
        // Update badges.
        [self setBadgesInfo];
    }];
}

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
            [self friendRequests];
            break;
        case 5:
            [self suggestions];
            break;
    }
}

#pragma mark - MyProfileViewController private auxiliary methods.

/*!
 @discussion This method sets the cells badges.
 */
- (void)setBadgesInfo
{
    _suggestions.badgeColor = [UIColor colorWithRed:0.35 green:0.142 blue:0.35 alpha:1.000];
    _suggestions.badge.radius = 5;
    _suggestions.badge.fontSize = 14;
    _suggestions.badgeString = [NSString stringWithFormat:@"%d", _user.suggestions.count];
    
    _requests.badgeColor = [UIColor colorWithRed:0.792 green:0.197 blue:0.219 alpha:1.000];
    _requests.badge.radius = 5;
    _requests.badge.fontSize = 14;
    _requests.badgeString = [NSString stringWithFormat:@"%d", _user.friendRequests.count];
}

/*!
 @discussion This method opens a table with the calendar of next episodes from user's 
 favorite shows.
 */
- (void)calendar
{
    //TODO
}

/*!
 @discussion This method opens a table with user friends's suggestions.
 */
- (void)suggestions
{
    SuggestionsViewController *view = [[SuggestionsViewController alloc] initWithData:_user.suggestions.allValues andTitle:@"Suggestions"];
    
    [self.navigationController pushViewController:view animated:YES];
}

/*!
 @discussion This method opens a table with friend requests for user.
 */
- (void)friendRequests
{
    UsersViewController *view = [[UsersViewController alloc] initWithData:_user.friendRequests.allValues andTitle:@"Friend requests"];
    
    [self.navigationController pushViewController:view animated:YES];
}

/*!
 @discussion This method opens a table with user's subscriptions.
 */
- (void)subscriptions
{
    UsersViewController *view = [[UsersViewController alloc] initWithData:_user.subscriptions.allValues andTitle:@"Subscriptions"];
    
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

@end
