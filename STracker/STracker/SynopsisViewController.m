//
//  SynopsesViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 21/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SynopsisViewController.h"
#import "Entity.h"

@implementation SynopsisViewController

#pragma mark - BaseTableViewController abstract methods.

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    // This is equals in all synopses table.
    EntitySynopsis *synopse = [_data objectAtIndex:indexPath.row];
    cell.textLabel.text = synopse.name;
}

@end
