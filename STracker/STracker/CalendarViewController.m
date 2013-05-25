//
//  CalendarViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 24/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CalendarViewController.h"

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
}

- (IBAction)searchOptions:(UIBarButtonItem *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Search" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Show by name", @"Shows by genre", @"Friend", nil];
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

#pragma mark - Action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *viewName;
    switch (buttonIndex) {
        case 0:
            viewName = @"SearchByName";
            break;
        case 1:
            viewName = @"SearchByGenre";
            break;
        case 2:
            viewName = @"SearchFriend";
            break;
        default:
            viewName = nil;
    }
    
    if (viewName == nil)
        return;
    
    UIViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:viewName];
    [self.navigationController pushViewController:view animated:YES];
}

@end