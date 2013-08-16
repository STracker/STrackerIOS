//
//  EpisodeViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "EpisodeViewController.h"
#import "ActorsViewController.h"
#import "EpisodeCommentsViewController.h"
#import "UIViewController+KNSemiModal.h"
#import "RatingsController.h"
#import "UIImageView+AFNetworking.h"

@implementation EpisodeViewController

- (id)initWithEpisode:(Episode *)episode
{
    /*
     The [super init] is not called because this instance is
     created from storyboard.
     */
    _episode = episode;
    return self;
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
    _swipeGestureDescription = nil;
    
    [super viewDidUnload];
}

#pragma mark - IBActions.
- (IBAction)options:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Information" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Guest Actors", @"Directors", @"Comments", nil];
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

- (IBAction)openDescription:(id)sender
{
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, 150)];
    text.backgroundColor = nil;
    [text setEditable:NO];
    [text setTextAlignment:NSTextAlignmentCenter];
    [text setFont:[UIFont fontWithName:@"Futura Medium" size:25.0]];
    [text setTextColor:[UIColor whiteColor]];
    text.text = _episode.description;
    
    [self presentSemiView:text];
}

#pragma mark - Action sheet delegate.

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

#pragma mark - RatingsViewController abstract methods.

- (void)postRating:(float)rating
{
    [RatingsController postEpisodeRating:rating episodeId:_episode.identifier finish:^(id obj) {
        
        // Nothing todo...
    }];
}

- (void)getRating
{
    [RatingsController getEpisodeRating:_episode.identifier finish:^(id obj) {
        
        [super setRatingInfo:obj];
    }];
}


#pragma mark - EpisodeViewController auxiliary private methods.

/*!
 @discussion Auxiliary method for set the episode information in
 outlets.
 */
- (void)configureView
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    self.navigationItem.title = _episode.name;
    
    _date.text = _episode.date;
    [_poster setImageWithURL:[NSURL URLWithString:_episode.poster]];
}

/*!
 @discussion Auxiliary method for showing the guest actors.
 */
- (void)guestActors
{
    ActorsViewController *view = [[ActorsViewController alloc] initWithData:_episode.guestActors andTitle:@"Guest actors"];
    [self.navigationController pushViewController:view animated:YES];
}

/*!
 @discussion Auxiliary method for showing the directors.
 */
- (void)directors
{
    PersonsViewController *view = [[PersonsViewController alloc] initWithData:_episode.directors andTitle:@"Directors"];
    [self.navigationController pushViewController:view animated:YES];
}

/*!
 @discussion Auxiliary method for showing the users comments.
 */
- (void)comments
{
    EpisodeCommentsViewController *view = [[EpisodeCommentsViewController alloc] initWithEpisode:_episode];
    [self.navigationController pushViewController:view animated:YES];
}

@end
