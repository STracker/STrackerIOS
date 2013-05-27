//
//  BaseViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BACKGROUND @"BackgroundPattern.png"

@interface BaseTableViewController : UITableViewController
{
    NSString *_navTitle;
    NSMutableArray *_data;
    int _numberOfSections;
    NSString *_cellIdentifier;
}

// Override of initWithCoder and init.
- (id)initWithCoder:(NSCoder *)aDecoder;
- (id)init;

// Hook methods.
- (void)initHook;
- (void)viewDidLoadHook;
- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath;

@end
