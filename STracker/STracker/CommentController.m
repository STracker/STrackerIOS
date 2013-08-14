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

+ (void)getTvShowComments:(NSString *)uri finish:(Finish) finish
{
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        TvShowComments *comments = [[TvShowComments alloc] initWithDictionary:result];

        // Invoke callback.
        finish(comments);
     
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)getEpisodeComments:(NSString *)uri finish:(Finish)finish
{
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
    
        EpisodeComments *comments = [[EpisodeComments alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(comments);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];

}

+ (void)postComment:(NSString *)uri comment:(NSString *)comment finish:(Finish) finish
{
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:comment, @"", nil];
        
    [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
            
        // Nothing todo here...
            
        // Invoke callback.
        finish(nil);
            
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)deleteComment:(NSString *)uri finish:(Finish)finish
{
    [[STrackerServerHttpClient sharedClient] deleteRequestWithHawkProtocol:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish(nil);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

@end
