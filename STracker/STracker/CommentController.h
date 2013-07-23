//
//  CommentController.h
//  STracker
//
//  Created by Ricardo Sousa on 23/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

// Definition of callback for code after comments get operation.
typedef void (^FinishGet)(NSArray *comments);

// Definition of callback for code after comments delete operation.
typedef void (^FinishDelete)();

/*!
 @discussion The propose of this object is for get and 
 post comments into STracker server via HTTP.
 */
@interface CommentController : NSObject
{
    AppDelegate *_app;
}

/*!
 @discussion Get comments from the request Uri.
 @param uri     Request Uri.
 @param finish  The callback when download is finish.
 */
- (void)getComments:(NSString *)uri finish:(FinishGet) finish;

/*!
 @discussion Post one comment into STracker server.
 @param uri     The Uri for post.
 @param comment The comment.
 */
- (void)postComment:(NSString *)uri comment:(NSString *)comment;

/*!
 @discussion Delete one comment into STracker server.
 @param uri     The Uri for delete.
 @param finish  The callback when delete is complete.
 */
- (void)deleteComment:(NSString *)uri finish:(FinishDelete) finish;

@end