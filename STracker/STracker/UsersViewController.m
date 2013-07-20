/*
//
//  UsersViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 10/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "UsersViewController.h"

@implementation UsersViewController

- (void)viewDidLoadHook
{
    self.navigationItem.title = @"Friends";
    _numberOfSections = 1;
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    User *user = [_data objectAtIndex:indexPath.row];
    
    cell.textLabel.text = user.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    User *user = [_data objectAtIndex:indexPath.row];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    [[STrackerServerHttpClient sharedClient] getUser:user.identifier success:^(AFJSONRequestOperation *operation, id result) {
        
        User *user = [[User alloc] initWithDictionary:result];
        
        ProfileViewController *view = [app.storyboard instantiateViewControllerWithIdentifier:@"Profile"];
        view.user = user;
        
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:nil];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    User *user = [_data objectAtIndex:indexPath.row];
    
    [[STrackerServerHttpClient sharedClient] deleteFriend:user.identifier success:^(AFJSONRequestOperation *operation, id result) {
        
        [_data removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        
    } failure:nil];
}

@end
 */
