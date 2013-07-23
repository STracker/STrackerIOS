//
//  ShowViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DLStarRatingControl.h"
#import "TvShow.h"
#import "Ratings.h"

/*!
 @discussion This controller shows all information about an television show.
 */
@interface TvShowViewController : BaseViewController <UIActionSheetDelegate, DLStarRatingDelegate>
{
    __weak IBOutlet UITextView *_description;
    __weak IBOutlet UILabel *_airDay;
    __weak IBOutlet UILabel *_firstAired;
    __weak IBOutlet UILabel *_runtime;
    __weak IBOutlet UIImageView *_poster;
    __weak IBOutlet UITextView *_genres;
    __weak IBOutlet DLStarRatingControl *_rating;
    __weak IBOutlet UILabel *_average;
    __weak IBOutlet UILabel *_numberOfUsers;
    
    TvShow *_tvshow;
    Ratings *_ratings;
}

/*!
 @discussion Init method for return an instance of TvShowViewController.
 Receives one instance of TvShow that contains all information about the 
 television show.
 @param tvshow The television show with information.
 @return An instance of TvShowViewController.
 */
- (id)initWithTvShow:(TvShow *)tvshow;

/*!
 @discussion The action method that is invoked when user click
 in user options icon.
 */
- (IBAction)options:(UIBarButtonItem *)sender;

@end