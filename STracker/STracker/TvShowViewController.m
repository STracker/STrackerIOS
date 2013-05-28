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
         
         self.navigationItem.title = _tvshow.name;
         _description.text = _tvshow.description;
         _runtime.text = [NSString stringWithFormat:@"%@", _tvshow.runtime];
         _airDay.text = _tvshow.airDay;
         _firstAired.text = _tvshow.firstAired;
         
         _poster.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_tvshow.poster]]];
         
         NSMutableString *str = [[NSMutableString alloc] init];
         for (id genre in _tvshow.genres) {
             [str appendString:[NSString stringWithFormat:@"- %@\n", genre]];
         }
         _genres.text = str;
         
     } failure:^(AFJSONRequestOperation *operation, NSError *error)
     {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
         
         [alert show];
     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    
    [self getInfo];
}

- (void)viewDidUnload
{
    _description = nil;
    _airDay = nil;
    _runtime = nil;
    _poster = nil;
    _firstAired = nil;
    _genres = nil;
    [super viewDidUnload];
}
@end
