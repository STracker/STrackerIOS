//
//  CalendarViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 24/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@interface CalendarViewController : BaseTableViewController <UIActionSheetDelegate>

- (IBAction)searchOptions:(UIBarButtonItem *)sender;

@end