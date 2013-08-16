//
//  GenresController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/24/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "AppDelegate.h"

/*!
 @discussion Info controller for manage television show
 information.
 */
@interface GenresController : NSObject

/*!
 @discussion Get all genres available.
 @param finish  The finish callback.
 */
+ (void)getGenres:(Finish) finish;

/*!
 @discussion Get one genre from request uri.
 @param uri     The resource uri.
 @param version The version of the resource, for cache control.
 @param finish  The finish callback.
 */
+ (void)getGenre:(NSString *) uri withVersion:(NSString *)version finish:(Finish) finish;

@end