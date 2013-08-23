//
//  BaseEditTableViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 23/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "BaseTableViewController.h"

/*!
 @discussion BaseTableViewController with edit options.
 */
@interface BaseEditTableViewController : BaseTableViewController

/*!
 @discussion Abstract method.
 @param indexPath   The indexpath of the cell for delete.
 */
- (void)deleteHookForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
