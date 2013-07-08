//
//  ShowViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "FacebookView.h"
#import "STrackerServerHttpClient.h"
#import "DownloadFiles.h"
#import "DLStarRatingControl.h"
#import "SeasonsViewController.h"
#import "PersonsViewController.h"
#import "TvShow.h"
#import "Genre.h"

#define BACKGROUND @"BackgroundPattern.png"

@interface TvShowViewController : UIViewController <UIActionSheetDelegate, DLStarRatingDelegate>
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
    
    float _userRating;
}

@property(nonatomic, strong) TvShow *tvshow;

- (IBAction)options:(UIBarButtonItem *)sender;

@end