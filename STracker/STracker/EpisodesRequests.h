//
//  EpisodesController.h
//  STracker
//
//  Created by Ricardo Sousa on 23/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "AppDelegate.h"

/*!
 @discussion Info requests for manage seasons
 information.
 */
@interface EpisodesRequests : NSObject

/*!
 @discussion Get one episode from request uri.
 @param uri     The resource uri.
 @param finish  The finish callback.
 */
+ (void)getEpisode:(NSString *)uri finish:(Finish) finish;

@end