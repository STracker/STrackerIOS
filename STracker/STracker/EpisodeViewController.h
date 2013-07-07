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

#define BACKGROUND @"BackgroundPattern.png"

@interface EpisodeViewController : UIViewController <UIActionSheetDelegate>
{
    __weak IBOutlet UIImageView *_poster;
    __weak IBOutlet UILabel *_date;
    __weak IBOutlet UITextView *_description;
}

@property(nonatomic, retain) Episode *episode;

- (IBAction)options:(id)sender;

@end
