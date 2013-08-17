//
//  TvShowsController.h
//  STracker
//
//  Created by Ricardo Sousa on 23/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "AppDelegate.h"
#import "TvShow.h"
#import "Range.h"

/*!
 @discussion Info controller for manage television show 
 information.
 */
@interface TvShowsController : NSObject

/*!
 @discussion Get one television show.
 @param uri     The resource uri.
 @param finish  The finish callback.
 */
+ (void)getTvShow:(NSString *)uri finish:(Finish) finish;

/*!
 @discussion Get television shows with same name.
 @param name    The tvshow name.
 @param range   The search range.
 @param finish  The finish callback.
 */
+ (void)getTvShowsByName:(NSString *)name withRange:(Range *)range finish:(Finish) finish;

/*!
 @discussion Get Top rated television shows.
 @param finish  The finish callback.
 */
+ (void)getTvShowsTopRated:(Finish) finish;

@end