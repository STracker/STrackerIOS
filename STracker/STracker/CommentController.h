//
//  CommentController.h
//  STracker
//
//  Created by Ricardo Sousa on 23/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoController.h"

/*!
 @discussion Info controller for manage comments 
 information.
 */
@interface CommentController : InfoController

/*!
 @discussion Get comments from the request Uri.
 @param uri     Request Uri.
 @param finish  The callback when download is finish.
 */
- (void)getComments:(NSString *)uri finish:(Finish) finish;

/*!
 @discussion Post one comment into STracker server.
 @param uri     The Uri for post.
 @param comment The comment.
 @param finish  The callback when post is finish.
 */
- (void)postComment:(NSString *)uri comment:(NSString *)comment finish:(Finish) finish;

/*!
 @discussion Delete one comment into STracker server.
 @param uri     The Uri for delete.
 @param finish  The callback when delete is complete.
 */
- (void)deleteComment:(NSString *)uri finish:(Finish) finish;

@end