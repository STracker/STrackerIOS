//
//  ShowViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowViewController.h"
#import "DownloadFiles.h"
#import "Genre.h"
#import "SeasonsViewController.h"
#import "ActorsViewController.h"
#import "TvShowCommentsViewController.h"

@implementation TvShowViewController

- (id)initWithTvShow:(TvShow *)tvshow
{
    /* 
     The [super init] is not called because this instance is 
     created from storyboard.
     */
    _tvshow = tvshow;
    _ratingsUri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerTvShowRatingsURI"];
    _ratingsUri = [_ratingsUri stringByReplacingOccurrencesOfString:@"id" withString:_tvshow.tvshowId];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [self configureView];
}

- (void)viewDidUnload
{
    _description = nil;
    _airDay = nil;
    _runtime = nil;
    _poster = nil;
    _firstAired = nil;
    _genres = nil;
    _rating = nil;
    _average = nil;
    _numberOfUsers = nil;
    
    [super viewDidUnload];
}

#pragma mark - IBActions.

- (IBAction)options:(UIBarButtonItem *)sender
{ 
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Information" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Seasons", @"Cast", @"Comments", @"Subscribe", @"Suggest", nil];
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

#pragma mark - Action sheet delegate.

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self seasons];
            break;
        case 1:
            [self cast];
            break;
        case 2:
            [self comments];
            break;
        case 3:
            //[self subscribe];
            break;
    }
    
    [actionSheet setDelegate:nil];
}

#pragma mark - UIAlert View delegates.

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
    {
        /*
        [[STrackerServerHttpClient sharedClient] postSubscription:tvshow success:^(AFJSONRequestOperation *operation, id result) {
            
            // Nothing to do...
            
        } failure:nil];
         */
    }
    
    [alertView setDelegate:nil];
    alertView = nil;
}

#pragma mark - TvShowViewController auxiliary private methods.

/*!
 @discussion Auxiliary method for set the television show information in 
 outlets.
 */
- (void)configureView
{
    self.navigationItem.title = _tvshow.name;
    
    _description.text = _tvshow.description;
    _runtime.text = [NSString stringWithFormat:@"%@ min", _tvshow.runtime];
    _airDay.text = _tvshow.airDay;
    _firstAired.text = _tvshow.firstAired;
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (GenreSynopse *genre in _tvshow.genres)
        [str appendString:[NSString stringWithFormat:@"- %@\n", genre.name]];
    
    _genres.text = str;
    
    [[DownloadFiles sharedObject] downloadImageFromUrl:[NSURL URLWithString:_tvshow.poster] finish:^(UIImage *image) {
        
        _poster.image = image;
    }];
}

/*!
 @discussion Auxiliary method for showing the seasons.
 */
- (void)seasons
{
    SeasonsViewController *view = [[SeasonsViewController alloc] initWithData:_tvshow.seasons];
    [self.navigationController pushViewController:view animated:YES];
}

/*!
 @discussion Auxiliary method for showing the cast.
 */
- (void)cast
{
    ActorsViewController *view = [[ActorsViewController alloc] initWithData:_tvshow.actors andTitle:@"Cast"];
    [self.navigationController pushViewController:view animated:YES];
}


/*!
 @discussion Auxiliary method for showing the users comments.
 */
- (void)comments
{
    TvShowCommentsViewController *view = [[TvShowCommentsViewController alloc] initWithTvShow:_tvshow];
    [self.navigationController pushViewController:view animated:YES];
}

/*
// Auxiliary method for subscribe this tvshow.
- (void)subscribe
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if (app.user == nil)
    {
        FacebookView *fb = [[FacebookView alloc] initWithController:self];
        [self presentSemiView:fb];
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:[NSString stringWithFormat:@"you really want to subscribe %@?", tvshow.name] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    [alert show];
}
*/
@end
