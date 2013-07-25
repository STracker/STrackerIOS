//
//  RatingViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 7/24/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "BaseViewController.h"
#import "DLStarRatingControl.h"

/*!
 @discussion Base view controller of all controllers that have 
 rating option.
 */
@interface RatingsViewController : BaseViewController <DLStarRatingDelegate>
{
    NSString *_ratingsUri;
    
    __weak IBOutlet DLStarRatingControl *_rating;
    __weak IBOutlet UILabel *_average;
}

@end