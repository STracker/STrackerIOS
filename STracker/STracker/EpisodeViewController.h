//
//  EpisodeViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingsViewController.h"
#import "Episode.h"

/*!
 @discussion This view controller shows the information about 
 one episode.
 */
@interface EpisodeViewController : RatingsViewController <UIActionSheetDelegate>
{
    @private
    __weak IBOutlet UIImageView *_poster;
    @private
    __weak IBOutlet UILabel *_date;
    @private
    IBOutlet UISwipeGestureRecognizer *_swipeGestureDescription;
    
    @private
    Episode *_episode;
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

/*!
 @discussion Action for open description view.
 */
- (IBAction)openDescription:(id)sender;

@end
