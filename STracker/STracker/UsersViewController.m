//
//  UsersViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 10/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "UsersViewController.h"
#import "User.h"
#import "UsersRequests.h"
#import "UserInfoManager.h"
#import "UserProfileViewController.h"
#import "MyProfileViewController.h"

@implementation UsersViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserSynopsis *synopsis = [_data objectAtIndex:indexPath.row];
    
    [_app.userManager getUser:^(User *me) {
        
        // Verify if the user is the current user.
        if ([me.identifier isEqualToString:synopsis.identifier])
        {
            MyProfileViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"MyProfile"] initWithUserInfo:me];
            [self.navigationController pushViewController:view animated:YES];
            return;
        }
        
        [UsersRequests getUser:synopsis.uri finish:^(id obj) {
            
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