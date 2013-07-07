//
//  OptionsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 24/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "OptionsViewController.h"

@implementation OptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    
    _app = [[UIApplication sharedApplication] delegate];
    
    self.navigationItem.title = _app.user.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            NSLog(@"Calendar");
            break;
        case 1:
            
            break;
        default:
            break;
    }
}

@end
