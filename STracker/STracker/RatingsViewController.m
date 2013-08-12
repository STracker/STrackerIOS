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
    
    [self getRating];
}

- (void)viewDidUnload
{
    _rating = nil;
    _average = nil;
    
    [super viewDidUnload];
}

-(void)newRating:(DLStarRatingControl *)control :(float)rating
{
    // Needed to be logged in Facebook for post an rating.
    [_app loginInFacebook:^(id obj) {
        
        [RatingsController postRating:_ratingsUri withRating:rating finish:^(id obj) {
            
            // Nothing todo...
        }];
    }];
}

#pragma mark - BaseViewController abstract methods.

/*!
 @discussion In this case, the data for refreshing is the rating information.
 */
- (void)shakeEvent
{
    [self getRating];
}

#pragma mark - RatingsViewController private auxiliary methods.

/*!
 @discussion Auxiliary method for make the request for rating information and set 
 the information into outlets.
 */
- (void)getRating
{
    [RatingsController getRating:_ratingsUri finish:^(id obj) {
        
        _average.text = [NSString stringWithFormat:@"%d/5 from %d user(s)", ((Rating *)obj).rating, ((Rating *)obj).numberOfUsers];
        _rating.rating = ((Rating *)obj).rating;
    }];
}

@end
