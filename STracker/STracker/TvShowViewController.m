//
//  ShowViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowViewController.h"

@implementation TvShowViewController

@synthesize tvshow;

- (void)getRating
{
    [[STrackerServerHttpClient sharedClient] getTvShowRating:tvshow success:^(AFJSONRequestOperation *operation, id result) {
        
        NSDictionary *data = (NSDictionary *)result;
        _average.text = [NSString stringWithFormat:@"%@/5", [data objectForKey:@"Rating"]];
        _numberOfUsers.text = [NSString stringWithFormat:@"%@ Users", [data objectForKey:@"Total"]];
        
    } failure:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    
    [self getRating];
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

// Auxiliary method for configure the components inside the main view.
- (void)configureView
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    self.navigationItem.title = tvshow.name;
    
    _description.text = tvshow.description;
    _runtime.text = [NSString stringWithFormat:@"%@ min", tvshow.runtime];
    _airDay.text = tvshow.airDay;
    _firstAired.text = tvshow.firstAired;
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (GenreSynopsis *genre in tvshow.genres)
    {
        [str appendString:[NSString stringWithFormat:@"- %@\n", genre.name]];
    }
    
    _genres.text = str;
    
    [[DownloadFiles sharedObject] downloadImageFromUrl:[NSURL URLWithString:tvshow.poster] finish:^(UIImage *image) {
        _poster.image = image;
    }];
}

# pragma mark - IBActions.
- (IBAction)options:(UIBarButtonItem *)sender
{ 
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Information" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Seasons", @"Cast", @"Comments", @"Subscribe", @"Suggest", nil];
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

#pragma mark - Action sheet delegate
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
    }
    
    [actionSheet setDelegate:nil];
}

// Auxiliary method for get seasons.
- (void)seasons
{
    SeasonsViewController *view = [[SeasonsViewController alloc] initWithData:tvshow.seasons];
    [self.navigationController pushViewController:view animated:YES];
}

// Auxiliary method for get the cast.
- (void)cast
{
    PersonsViewController *view = [[PersonsViewController alloc] initWithData:tvshow.actors];
    [self.navigationController pushViewController:view animated:YES];
}

// Auxiliary method for get and create comments.
- (void)comments
{
    [[STrackerServerHttpClient sharedClient] getTvshowComments:tvshow success:^(AFJSONRequestOperation *operation, id result) {
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            Comment *comment = [[Comment alloc] initWithDictionary:item];
            [data addObject:comment];
        }
        
        TvShowCommentsViewController *view = [[TvShowCommentsViewController alloc] initWithData:data andTvShow:tvshow];
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:nil];
}

#pragma mark - DLStarRatingControl delegate
-(void)newRating:(DLStarRatingControl *)control :(float)rating
{
	AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if (app.user == nil)
    {
        // Clean rating because the user is not yet logged in.
        [_rating setRating:0];
        
        FacebookView *fb = [[FacebookView alloc] initWithController:self];
        [self presentSemiView:fb];
        return;
    }
    
    [[STrackerServerHttpClient sharedClient] postTvShowRating:self.tvshow rating:rating success:^(AFJSONRequestOperation *operation, id result) {
        
        // Reload information.
        [self getRating];
        
    } failure:nil];
}

@end
