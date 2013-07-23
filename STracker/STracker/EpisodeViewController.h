//
//  EpisodeViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DLStarRatingControl.h"
#import "Episode.h"
#import "Ratings.h"

/*!
 @discussion This view controller shows the information about 
 one episode.
 */
@interface EpisodeViewController : BaseViewController <UIActionSheetDelegate, DLStarRatingDelegate>
{
    __weak IBOutlet UIImageView *_poster;
    __weak IBOutlet UILabel *_date;
    __weak IBOutlet UITextView *_description;
    __weak IBOutlet UILabel *_average;
    __weak IBOutlet UILabel *_numberOfUsers;
    __weak IBOutlet DLStarRatingControl *_rating;
    
    Episode *_episode;
    Ratings *_ratings;
}

/*!
 @discussion Init method for get an instance of EpisodeViewController.
 Receives the episode that contains all information.
 @param episode The episode.
 @return An EpisodeViewController instance.
 */
- (id)initWithEpisode:(Episode *)episode;

/*!
 @discussion The action method that is invoked when user click
 in user options icon.
 */
- (IBAction)options:(id)sender;

@end
