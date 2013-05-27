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

@interface TvShowViewController : UIViewController
{
    TvShow *_tvshow;
    __weak IBOutlet UILabel *_name;
    __weak IBOutlet UILabel *_imdbId;
    __weak IBOutlet UITextView *_description;
}

@property(nonatomic, copy) NSString *imdbId;

@end
