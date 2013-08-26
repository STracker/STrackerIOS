//
//  RatingViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/24/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "RatingsViewController.h"
#import "Rating.h"

@implementation RatingsViewController

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

- (void)setRatingInfo:(Rating *) rating
{
    _average.text = [NSString stringWithFormat:@"%d/5 from %d user(s)", rating.rating, rating.numberOfUsers];
    _rating.rating = rating.rating;
}

- (void)postRating:(float)rating
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

- (void)getRating
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

#pragma mark - DLStarRatingControl delegate.

-(void)newRating:(DLStarRatingControl *)control :(float)rating
{
    [self postRating:rating];
}

#pragma mark - BaseViewController abstract methods.

/*!
 @discussion In this case, the data for refreshing is the rating information.
 */
- (void)shakeEvent
{
    [self getRating];
}

@end
