//
//  RatingViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/24/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "BaseViewController.h"
#import "DLStarRatingControl.h"
#import "Rating.h"

/*!
 @discussion Base view controller of all controllers that have 
 rating option.
 */
@interface RatingsViewController : BaseViewController <DLStarRatingDelegate>
{
    __weak IBOutlet DLStarRatingControl *_rating;
    __weak IBOutlet UILabel *_average;
}

/*!
 @discussion Method for set the DLStarRating information.
 @param rating The rating object with rating information.
 */
- (void)setRatingInfo:(Rating *) rating;

/*!
 @discussion Abstract method for post one rating to server.
 @param rating The user's rating.
 */
- (void)postRating:(float) rating;

/*!
 @discussion Abstract method for get the rating from server.
 */
- (void)getRating;

@end