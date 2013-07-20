/*
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
  
    int count = 1;
    for (Person *person in _data)
    {
        [[DownloadFiles sharedObject] downloadImageFromUrl:[NSURL URLWithString:person.photoURL] finish:^(UIImage *image) {
            person.image = image;
            if (count == _data.count)
            {
                // Reload data for show the images.
                [self.tableView reloadData];
            }
        }];
        
        count++;
    }
}

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    Person *person = [_data objectAtIndex:indexPath.row];
    
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    cell.textLabel.text = person.name;
    
    if ([person isKindOfClass:[Actor class]]) {
        cell.detailTextLabel.text = ((Actor *)person).characterName;
        cell.imageView.image = ((Actor *)person).image;
    }
}

@end
*/