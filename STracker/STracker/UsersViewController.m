//
//  UsersViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 10/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "UsersViewController.h"
#import "User.h"
#import "UsersController.h"
#import "UserProfileViewController.h"
#import "MyProfileViewController.h"

@implementation UsersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *bt = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(moreUsers)];
    
    [self.navigationItem setRightBarButtonItem:bt animated:YES];
}

- (void)moreUsers
{
    Range *range = [[Range alloc] init];
    range.start = [_data count];
    range.end = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerElemsPerSearch"] intValue] + [_data count];
    
    [UsersController searchUser:_tableTitle withRange:range finish:^(id obj) {
        
        NSMutableArray *tvshows = [[NSMutableArray alloc] initWithArray:_data];
        [tvshows addObjectsFromArray:obj];
        
        // reload table for show the new television shows.
        _data = tvshows;
        [_tableView reloadData];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserSynopsis *synopsis = [_data objectAtIndex:indexPath.row];
    
    // Don't need to be the most updated version of user information for this action.
    [_app getUser:^(User *me) {
        
        // Verify if the user is the current user.
        if ([me.identifier isEqualToString:synopsis.identifier])
        {
            MyProfileViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"MyProfile"] initWithUserInfo:me];
            [self.navigationController pushViewController:view animated:YES];
            return;
        }
        
        [UsersController getUser:synopsis.uri finish:^(id obj) {
            
            UserProfileViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"UserProfile"] initWithUserInfo:obj];
            [self.navigationController pushViewController:view animated:YES];
        }];
    }];
}

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    [super configureCellHook:cell inIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
}

@end