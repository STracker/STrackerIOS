//
//  Ratings.m
//  STracker
//
//  Created by Ricardo Sousa on 7/22/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Ratings.h"
#import "STrackerServerHttpClient.h"
#import "AppDelegate.h"

@implementation Ratings

- (id)initWithAverage:(UILabel *)average andNumberOfUsers:(UILabel *)numberOfUsers
{
    if (self = [super init])
    {
        _app = [[UIApplication sharedApplication] delegate];
        
        _average = average;
        _numberOfUsers = numberOfUsers;
    }
    
    return self;
}

- (void)getRating:(NSString *)uri
{
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        // Set rating values.
        _average.text = [NSString stringWithFormat:@"%@/5", [result objectForKey:@"Rating"]];
        _numberOfUsers.text = [NSString stringWithFormat:@"%@ Users", [result objectForKey:@"Total"]];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

- (void)postRating:(NSString *)uri withRating:(float)rating
{
    // For this operation user must be loged in Facebook.
    [_app loginInFacebook:^(User *user) {
        
        NSString * ratingStr = [NSString stringWithFormat:@"%d", (int)rating];

        NSDictionary *parameters = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:ratingStr] forKeys:[NSArray arrayWithObject:@""]];

        [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
            
            // Reload rating information.
            [self getRating:uri];
            
        } failure:^(AFJSONRequestOperation *operation, NSError *error) {
            
            [[_app getAlertViewForErrors:error.localizedDescription] show];
        }];
    }];
}

@end
