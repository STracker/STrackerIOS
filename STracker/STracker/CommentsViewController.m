//
//  CommentsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CommentsViewController.h"

@implementation CommentsViewController

#pragma mark - Hook methods.
- (void)viewDidLoadHook
{
    self.navigationItem.title = @"Comments";
    _numberOfSections = 1;
}

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    Comment *comment = [_data objectAtIndex:indexPath.row];
    
    cell.textLabel.text = comment.body;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    CommentViewController *view = [app.storyboard instantiateViewControllerWithIdentifier:@"Comment"];
    view.comment = [_data objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:view animated:YES];
}

@end