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
         
         NSMutableString *str = [[NSMutableString alloc] init];
         for (id genre in _tvshow.genres) {
             [str appendString:[NSString stringWithFormat:@"- %@\n", genre]];
         }
         _genres.text = str;
         
         dispatch_queue_t downloadQueue = dispatch_queue_create("get_image", nil);
         dispatch_async(downloadQueue, ^{
             UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_tvshow.poster]]];
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 _poster.image = img;
                 
                 [_activity stopAnimating];      
                 _activity = nil;
             });
         });
         
     } failure:^(AFJSONRequestOperation *operation, NSError *error)
     {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
         
         [alert show];
         
         [_activity stopAnimating];    
         _activity = nil;
     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    
    _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:_activity];
    self.navigationItem.rightBarButtonItem = button;
    
    
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
