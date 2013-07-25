//
//  ShowViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TvShow.h"
#import "RatingsViewController.h"

/*!
 @discussion This controller shows all information about an television show.
 */
@interface TvShowViewController : RatingsViewController <UIActionSheetDelegate>
{
    __weak IBOutlet UILabel *_airDay;
    __weak IBOutlet UILabel *_firstAired;
    __weak IBOutlet UIImageView *_poster;
    __weak IBOutlet UITextView *_genres;
    IBOutlet UISwipeGestureRecognizer *_swipeGestureSeasons;
    IBOutlet UISwipeGestureRecognizer *_swipeGestureDescription;

    TvShow *_tvshow;
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

/*!
 @discussion Action for open seasons table.
 */
- (IBAction)openSeasons:(id)sender;

/*!
 @discussion Action for open description view.
 */
- (IBAction)openDescription:(id)sender;

@end