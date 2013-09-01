//
//  PersonsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "PersonsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Person.h"

@implementation PersonsViewController

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    Person *person = [_data objectAtIndex:indexPath.row];
    cell.textLabel.text = person.name;
    [cell.imageView setImageWithURL:[NSURL URLWithString:person.photoUrl]];
        
    // TODO, resize image.
}

@end