//
//  Ratings.m
//  STracker
//
//  Created by Ricardo Sousa on 7/22/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "RatingsController.h"
#import "STrackerServerHttpClient.h"
#import "Rating.h"

@implementation RatingsController

- (void)getRating:(NSString *)uri finish:(Finish) finish
{
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        Rating *rating = [[Rating alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(rating);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

- (void)postRating:(NSString *)uri withRating:(float)rating finish:(Finish) finish
{
    NSString * ratingStr = [NSString stringWithFormat:@"%d", (int)rating];
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:ratingStr] forKeys:[NSArray arrayWithObject:@""]];

    [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
            
        // Nothing todo...
        
        // Invoke callback.
        finish(nil);
            
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
            
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

#pragma mark - InfoController abstract methods.

+ (id)sharedObject
{
    static RatingsController *sharedObject = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[RatingsController alloc] init];
    });
    
    return sharedObject;
}

@end
