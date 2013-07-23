//
//  SeasonsController.h
//  STracker
//
//  Created by Ricardo Sousa on 23/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "InfoController.h"

/*!
 @discussion Info controller for manage seasons
 information.
 */
@interface SeasonsController : InfoController

/*!
 @discussion Get one season from request uri.
 @param uri     The request uri.
 @param finish  The finish callback.
 */
- (void)getSeason:(NSString *)uri finish:(Finish) finish;

@end
