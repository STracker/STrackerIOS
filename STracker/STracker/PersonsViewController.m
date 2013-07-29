//
//  PersonsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "PersonsViewController.h"
#import "DownloadFiles.h"

@implementation PersonsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int count = 0;
    for (PersonSynopsis *person in _data)
    {
        count++;
        if (person.photo != nil)
            continue;
        
        [[DownloadFiles sharedObject] downloadImageFromUrl:[NSURL URLWithString:person.photoUrl] finish:^(UIImage *image) {
            
            person.photo = image;
            
            if (count == [_data count])
                [_tableView reloadData];
        }];
    }
}

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    PersonSynopsis *person = [_data objectAtIndex:indexPath.row];
    cell.textLabel.text = person.name;
    cell.imageView.image = person.photo;
    
    // TODO, resize image.
}

@end