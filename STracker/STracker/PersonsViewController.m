//
//  PersonsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "PersonsViewController.h"

@implementation PersonsViewController

- (void)viewDidLoadHook
{
    self.navigationItem.title = @"Cast";
    _numberOfSections = 1;
}

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    Person *person = [_data objectAtIndex:indexPath.row];
    cell.textLabel.text = person.name;
    
    /*
    [DownloadFiles downloadImageFromUrl:[NSURL URLWithString:actor.photo] finish:^(UIImage *image) {
        [cell.imageView setImage:image];
        
        if (indexPath.row == _data.count)
            [self.tableView reloadData];
    }];
     */
}

@end
