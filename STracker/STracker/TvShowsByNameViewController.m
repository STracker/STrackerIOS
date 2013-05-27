//
//  TvShowsByNameViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowsByNameViewController.h"

@implementation TvShowsByNameViewController

@synthesize name;

#pragma mark - Override TvShowsViewController methods.
- (void)viewDidLoadHook
{
    //TODO...
}

- (void)initHook
{
    _navTitle = name;
    _cellIdentifier = @"TvShowSynopseCell";
    _numberOfSections = 1;
}

@end
