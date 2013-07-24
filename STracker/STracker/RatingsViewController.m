//
//  RatingViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/24/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "RatingsViewController.h"
#import "RatingsController.h"
#import "Rating.h"

@implementation RatingsViewController

#pragma mark - DLStarRatingControl delegate.

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[RatingsController sharedObject] getRating:_ratingsUri finish:^(id obj) {
        
        _average.text = [NSString stringWithFormat:@"%d/5", ((Rating *)obj).rating];
        _numberOfUsers.text = [NSString stringWithFormat:@"%d user(s)", ((Rating *)obj).numberOfUsers];
    }];
}

-(void)newRating:(DLStarRatingControl *)control :(float)rating
{
    // Needed to be logged in Facebook for post an rating.
    [_app loginInFacebook:^(id obj) {
        
        [[RatingsController sharedObject] postRating:_ratingsUri withRating:rating finish:^(id obj) {
            
            // Nothing todo...
        }];
    }];
}

@end
