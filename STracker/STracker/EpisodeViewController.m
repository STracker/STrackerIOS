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

// Auxiliary method for configure components of main view.
- (void)configureView
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    self.navigationItem.title = episode.name;
    
    _date.text = episode.date;
    _description.text = episode.description;
}

#pragma mark - IBActions.
- (IBAction)options:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Information" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Guest Actors", @"Directors", @"Comments", nil];
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
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

// Auxiliary method for show gest actors.
- (void)guestActors
{
    PersonsViewController *view = [[PersonsViewController alloc] initWithData:episode.guestActors];
    [self.navigationController pushViewController:view animated:YES];
}

// Auxiliary method for show directors.
- (void)directors
{
    PersonsViewController *view = [[PersonsViewController alloc] initWithData:episode.directors];
    [self.navigationController pushViewController:view animated:YES];
}

// Auxiliary method for show and create comments.
- (void)comments
{
    //TODO
}

@end
