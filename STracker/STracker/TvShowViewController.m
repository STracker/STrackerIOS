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

- (void)getPoster
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicator setCenter:_poster.center];
    [_poster addSubview:indicator];
    
    [indicator startAnimating];
    
    [DownloadFiles downloadImageFromUrl:[NSURL URLWithString:tvshow.poster] finish:^(UIImage *image) {
        _poster.image = image;
        [indicator stopAnimating];
        [indicator removeFromSuperview];
    }];
}

- (void)configureView
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    self.navigationItem.title = tvshow.name;
    
    _description.text = tvshow.description;
    _runtime.text = [NSString stringWithFormat:@"%@", tvshow.runtime];
    _airDay.text = tvshow.airDay;
    _firstAired.text = tvshow.firstAired;
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (GenreSynopsis *genre in tvshow.genres)
    {
        [str appendString:[NSString stringWithFormat:@"- %@\n", genre.name]];
    }
    _genres.text = str;
    
    [self getPoster];
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
    [super viewDidUnload];
}

- (IBAction)options:(UIBarButtonItem *)sender
{ 
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Information" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Seasons", @"Cast", @"Comments", nil];
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

- (void)seasons
{
    SeasonsViewController *view = [[SeasonsViewController alloc] initWithData:tvshow.seasons];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)cast
{
    PersonsViewController *view = [[PersonsViewController alloc] initWithData:tvshow.actors];
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - Action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex)
    {
        case 0:
            [self seasons];
            break;
        case 1:
            [self cast];
            break;
        case 2:
            // TODO...
            break;
    }
    [actionSheet setDelegate:nil];
}

@end
