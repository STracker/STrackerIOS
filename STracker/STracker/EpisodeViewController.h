/*
//
//  EpisodeViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DownloadFiles.h"
#import "PersonsViewController.h"
#import "Episode.h"
#import "Person.h"
#import "DLStarRatingControl.h"
#import "FacebookView.h"
#import "STrackerServerHttpClient.h"
#import "EpisodeCommentsViewController.h"

#define BACKGROUND @"BackgroundPattern.png"

@interface EpisodeViewController : UIViewController <UIActionSheetDelegate, DLStarRatingDelegate>
{
    __weak IBOutlet UIImageView *_poster;
    __weak IBOutlet UILabel *_date;
    __weak IBOutlet UITextView *_description;
    __weak IBOutlet UILabel *_average;
    __weak IBOutlet UILabel *_numberOfUsers;
    __weak IBOutlet DLStarRatingControl *_rating;
}

@property(nonatomic, retain) Episode *episode;

- (IBAction)options:(id)sender;

@end
 */
