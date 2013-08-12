//
//  TvShowsController.h
//  STracker
//
//  Created by Ricardo Sousa on 23/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "AppDelegate.h"
#import "TvShow.h"

/*!
 @discussion Info controller for manage television show 
 information.
 */
@interface TvShowsController : NSObject

/*!
 @discussion Get one television show.
 @param uri         The uri for make the request.
 @param finish      The finish callback.
 */
+ (void)getTvShow:(NSString *)uri finish:(Finish) finish;

/*!
 @discussion Get television shows with same name.
 @param name    The tvshow name.
 @param uri     The uri for make the request.
 @param finish  The finish callback.
 */
+ (void)getTvShowsByName:(NSString *)name uri:(NSString *)uri finish:(Finish) finish;

/*!
 @discussion Get Top rated television shows.
 @param uri     The uri for make the request.
 @param finish  The finish callback.
 */
+ (void)getTvShowsTopRated:(NSString *)uri finish:(Finish) finish;

@end