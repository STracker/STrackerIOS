//
//  EpisodeViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "EpisodeViewController.h"

@implementation EpisodeViewController

@synthesize episode;

- (void)getPoster
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicator setCenter:_poster.center];
    [_poster addSubview:indicator];
    
    [indicator startAnimating];
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("get_image", nil);
    dispatch_async(downloadQueue, ^{
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:episode.poster]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _poster.image = img;
            
            [indicator stopAnimating];
            [indicator removeFromSuperview];
        });
    });
}

- (void)configureView
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    self.navigationItem.title = episode.name;
    
    _date.text = episode.date;
    _description.text = episode.description;
    
    [self getPoster];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureView];
	
}

- (void)viewDidUnload
{
    _poster = nil;
    _date = nil;
    _description = nil;
    [super viewDidUnload];
}

- (IBAction)options:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Information" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Guest Actors", @"Directors", @"Comments", nil];
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

- (void)guestActors
{
    PersonsViewController *view = [[PersonsViewController alloc] initWithData:episode.guestActors];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)directors
{
    PersonsViewController *view = [[PersonsViewController alloc] initWithData:episode.directors];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)comments
{
    //TODO
}

#pragma mark - Action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self guestActors];
            break;
        case 1:
            [self directors];
            break;
        case 2:
            [self comments];
            break;
    }
    
    [actionSheet setDelegate:nil];
}

@end
