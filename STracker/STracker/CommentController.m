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

- (void)getComments:(NSString *)uri finish:(FinishGet) finish
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

- (void)postComment:(NSString *)uri comment:(NSString *)comment
{
    [_app loginInFacebook:^(User *user) {
        
        NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:comment, @"", nil];
        
        [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
            
            UIAlertView *alertConfirm = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Hi %@", user.name] message:@"your comment will be processed..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alertConfirm show];
            
        } failure:^(AFJSONRequestOperation *operation, NSError *error) {
            
            [[_app getAlertViewForErrors:error.localizedDescription] show];
        }];
    }];
}

- (void)deleteComment:(NSString *)uri finish:(FinishDelete)finish
{
    [[STrackerServerHttpClient sharedClient] deleteRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish();
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

@end
