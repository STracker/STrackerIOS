//
//  ViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 09/04/13.
//  Copyright (c) 2013 Ricardo Sousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TvShow.h"
#import "Actor.h"
#import "Season.h"
#import "SeasonsTableViewController.h"

@interface ViewController : UIViewController
{
    IBOutlet UILabel *tvShowName;
    IBOutlet UITextView *infoSummary;
    IBOutlet UIBarButtonItem *getInfoButton;
    IBOutlet UIButton *showSeasonsButton;
    
    TvShow *tvshow;
}

- (IBAction)getInfo:(id)sender;

- (IBAction)showSeasons:(id)sender;

@end
