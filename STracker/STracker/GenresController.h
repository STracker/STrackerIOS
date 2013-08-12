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
 @param uri         The uri for make the request.
 @param finish      The finish callback.
 */
+ (void)getGenres:(NSString *)uri finish:(Finish) finish;

/*!
 @discussion Get one genre from request uri.
 @param name    The genre name.
 @param uri     The uri for make the request.
 @param finish  The finish callback.
 */
+ (void)getGenre:(NSString *) uri finish:(Finish) finish;

@end
