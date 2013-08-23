//
//  BaseEditTableViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 23/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "BaseEditTableViewController.h"

@implementation BaseEditTableViewController

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

- (void)deleteHookForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate
{
    [super setEditing:editing animated:animate];
    [_tableView setEditing:editing animated:animate];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle != UITableViewCellEditingStyleDelete)
        return;
    
    [self deleteHookForRowAtIndexPath:indexPath];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
