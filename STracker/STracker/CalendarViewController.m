//
//  CalendarViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 24/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CalendarViewController.h"

@implementation CalendarViewController

- (IBAction)searchOptions:(UIBarButtonItem *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Search" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Show by name", @"Shows by genre", @"Friend", nil];
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

#pragma mark - BaseTableViewController override methods.
- (void)initHook
{
    _cellIdentifier = @"CalendarCell";
    _numberOfSections = 1; // For change!
}

- (void)viewDidLoadHook
{
    self.navigationItem.title = @"Calendar";
}

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    // TODO, implement this method!
}

#pragma mark - Action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *viewName;
    switch (buttonIndex) {
        case 0:
            // TODO...
            break;
        case 1:
            viewName = @"SearchByGenre";
            break;
        case 2:
            // TODO...
            break;
        default:
            viewName = nil;
    }
    
    if (viewName == nil)
        return;
    
    UIViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:viewName];
    [self.navigationController pushViewController:view animated:YES];
    
    [actionSheet setDelegate:nil];
}

@end