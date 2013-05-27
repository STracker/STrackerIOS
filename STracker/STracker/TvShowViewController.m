//
//  ShowViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowViewController.h"

@implementation TvShowViewController

@synthesize imdbId;

- (void)getInfo
{
    STrackerServerHttpClient *client = [STrackerServerHttpClient sharedClient];
    
    [client getByImdbId:imdbId success:^(AFJSONRequestOperation * operation, id result)
     {
         _tvshow = [[TvShow alloc] initWithDictionary:(NSDictionary *)result];
         
         _name.text = _tvshow.name;
         _imdbId.text = _tvshow.imdbId;
         _description.text = _tvshow.description;
         
     } failure:^(AFJSONRequestOperation *operation, NSError *error)
     {
         NSLog(@"failure");
     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getInfo];
}

- (void)viewDidUnload {
    _name = nil;
    _imdbId = nil;
    _description = nil;
    [super viewDidUnload];
}
@end
