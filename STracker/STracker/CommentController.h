//
//  CommentController.h
//  STracker
//
//  Created by Ricardo Sousa on 23/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Episode.h"

/*!
 @discussion Info controller for manage comments 
 information.
 */
@interface CommentController : NSObject

/*!
 @discussion Get tvshow comments from the request Uri.
 @param tvshowId    The television show identifier.
 @param version     The version of the resource, for cache control.
 @param finish      The callback when download is finish.
 */
+ (void)getTvShowComments:(NSString *)tvshowId withVersion:(NSString *)version finish:(Finish) finish;

/*!
 @discussion Get episode comments from the request Uri.
 @param episodeId   The episode identifier.
 @param version     The version of the resource, for cache control.
 @param finish      The callback when download is finish.
 */
+ (void)getEpisodeComments:(EpisodeId *)episodeId withVersion:(NSString *)version finish:(Finish) finish;

/*!
 @discussion Post one television show comment into STracker server.
 @param tvshowId    The television show identifier.
 @param comment     The comment.
 @param finish      The callback when post is finish.
 */
+ (void)postTvShowComment:(NSString *)tvshowId comment:(NSString *)comment finish:(Finish) finish;

/*!
 @discussion Post one comment into STracker server.
 @param episodeId   The television show identifier.
 @param comment     The comment.
 @param finish      The callback when post is finish.
 */
+ (void)postEpisodeComment:(EpisodeId *)episodeId comment:(NSString *)comment finish:(Finish) finish;

/*!
 @discussion Delete one comment into STracker server.
 @param uri     The comment uri.
 @param finish  The callback when delete is complete.
 */
+ (void)deleteComment:(NSString *)uri finish:(Finish) finish;

@end