//
//  BaseViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

#define CELLIDENTIFIER @"BaseTableCell"

/*!
 @discussion This controller is a base controller for table views.
 Contains all things that are equal beteween the table views.
 */
@interface BaseTableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_data;
    NSString *_tableTitle;
    
    UITableView *_tableView;
}

/*!
 @discussion This init method, creates an instance receiving the data 
 that are used to populate the table view.
 @param data The data.
 @return An instance of BaseTableViewController.
 */
- (id)initWithData:(NSArray *)data;

/*!
 @discussion This init method, creates an instance receiving the data
 that are used to populate the table view and the title for the table view.
 @param data    The data.
 @param title   The title of table view.
 @return An instance of BaseTableViewController.
 */
- (id)initWithData:(NSArray *)data andTitle:(NSString *)title;

/*!
 @discussion This method is a hook method, that is implemented in the sub-table views.
 */
- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath;

@end