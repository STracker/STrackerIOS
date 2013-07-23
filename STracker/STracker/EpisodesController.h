//
//  EpisodesController.h
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
@interface EpisodesController : InfoController

/*!
 @discussion Get one episode from request uri.
 @param uri     The request uri.
 @param finish  The finish callback.
 */
- (void)getEpisode:(NSString *)uri finish:(Finish) finish;

@end
