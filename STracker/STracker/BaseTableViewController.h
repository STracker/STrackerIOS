//
//  BaseViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Entity.h"

#define BACKGROUND @"BackgroundPattern.png"
#define CELLIDENTIFIER @"BaseTableCell"

@interface BaseTableViewController : UITableViewController
{
    NSMutableArray *_data;
    EntitySynopse *_synopse;
    
    AppDelegate *_app;
}

// Init method.
- (id)initWithData:(NSMutableArray *)data;

- (id)initWithData:(NSMutableArray *)data andSynopse:(EntitySynopse *)synopse;

// Hook methods.
- (void)viewDidLoadHook;
- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath;

@end