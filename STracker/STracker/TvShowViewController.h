//
//  ShowViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STrackerServerHttpClient.h"
#import "TvShow.h"

#define BACKGROUND @"BackgroundPattern.png"

@interface TvShowViewController : UIViewController
{
    TvShow *_tvshow;
    __weak IBOutlet UITextView *_description;
    __weak IBOutlet UILabel *_airDay;
    __weak IBOutlet UILabel *_firstAired;
    __weak IBOutlet UILabel *_runtime;
    __weak IBOutlet UIImageView *_poster;
    __weak IBOutlet UITextView *_genres;
}

@property(nonatomic, copy) NSString *imdbId;

@end
