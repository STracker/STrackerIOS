//
//  TvShowsByGenreViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowsByGenreViewController.h"

@implementation TvShowsByGenreViewController

@synthesize genre;

#pragma mark - Override TvShowsViewController methods.
- (void)viewDidLoadHook
{
    // Get information from server.
    [[STrackerServerHttpClient sharedClient] getByGenre:genre success:^(AFJSONRequestOperation * operation, id result)
     {
         [super fillTable:(NSDictionary *)result];
         
     } failure:^(AFJSONRequestOperation *operation, NSError *error)
     {
         [super failure:error];
     }];
}

- (void)initHook
{
    _navTitle = genre;
    _cellIdentifier = @"TvShowSynopseCell";
    _numberOfSections = 1;
}

@end
