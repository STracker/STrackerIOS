//
//  BaseViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BACKGROUND @"BackgroundPattern.png"
#define CELLIDENTIFIER @"BaseTableCell"

@interface BaseTableViewController : UITableViewController
{
    NSMutableArray *_data;
    int _numberOfSections;
}

// Init method.
- (id)initWithData:(NSMutableArray *)data;

// Hook methods.
- (void)viewDidLoadHook;
- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath;

@end