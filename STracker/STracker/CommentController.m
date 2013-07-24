//
//  CommentController.m
//  STracker
//
//  Created by Ricardo Sousa on 23/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CommentController.h"
#import "STrackerServerHttpClient.h"
#import "Comment.h"

@implementation CommentController

/*!
 @discussion Override init method for set _app field.
 */
- (id)init
{
    if (self = [super init])
        _app = [[UIApplication sharedApplication] delegate];
    
    return self;
}

- (void)getComments:(NSString *)uri finish:(Finish) finish
{
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            Comment *comment = [[Comment alloc] initWithDictionary:item];
            [data addObject:comment];
        }
     
        // Invoke callback.
        finish(data);
     
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

- (void)postComment:(NSString *)uri comment:(NSString *)comment finish:(Finish) finish
{
    [_app loginInFacebook:^(User *user) {
        
        NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:comment, @"", nil];
        
        [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
            
            
            // Nothing todo here...
            
            // Invoke callback.
            finish(nil);
            
        } failure:^(AFJSONRequestOperation *operation, NSError *error) {
            
            [[_app getAlertViewForErrors:error.localizedDescription] show];
        }];
    }];
}

- (void)deleteComment:(NSString *)uri finish:(Finish)finish
{
    [[STrackerServerHttpClient sharedClient] deleteRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish(nil);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

#pragma mark - InfoController abstract methods.

+ (id)sharedObject
{
    static CommentController *sharedObject = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[CommentController alloc] init];
    });
    
    return sharedObject;
}

@end
