//
//  Ratings.h
//  STracker
//
//  Created by Ricardo Sousa on 7/22/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

/*!
 @discussion Info controller for manage ratings 
 information.
 */
@interface RatingsController : NSObject

/*!
 @discussion Get rating from STracker server.
 @param uri     The request uri. Normally from tv show or episode.
 @param finish  The finish callback.
 */
+ (void)getRating:(NSString *)uri finish:(Finish) finish;

/*!
 @discussion Post an rating in STracker server.
 @param uri     The request uri. Normally from tv show or episode.
 @param rating  The user's rating.
 @param finish  The finish callback.
 */
+ (void)postRating:(NSString *)uri withRating:(float)rating finish:(Finish) finish;

@end