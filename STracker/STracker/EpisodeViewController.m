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
#import "Subscription.h"
#import "UsersController.h"

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
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Information" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Guest Actors", @"Directors", @"Comments", @"Watched", nil];
    
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
        case 3:
            [self watched];
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

#pragma mark - UIAlert View delegates.

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
    {
        if (alertView == _alertWatched)
            [self watechedRequest];
        
        if (alertView == _alertUnWatched)
            [self unWatechedRequest];
    }
    
    [alertView setDelegate:nil];
    alertView = nil;
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

/*!
 @discussion Auxiliary method for mark/unmark as seen, the episode.
 */
- (void)watched
{
    // Verify date.
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:_episode.date];
    
    if ([_episode.date isEqualToString:@"N/A"] || [dateFromString compare:[NSDate date]] == NSOrderedDescending)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention!" message:@"this episode has not yet aired." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        
        [alert show];
        return;
    }
    
    
    /*
     Need the most updated information for see if the user have this
     episode marked or not.
     */
    [_app getUpdatedUser:^(User *user) {
        
        Subscription *sub = [user.subscriptions objectForKey:_episode.identifier.tvshowId];
        if (sub == nil)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention!" message:@"you are not subscribed to this television show." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alert show];
            return;
        }
        
        for (EpisodeSynopsis *epi in sub.episodesWatched)
        {
            if ((epi.identifier.seasonNumber == _episode.identifier.seasonNumber) && (epi.identifier.episodeNumber == _episode.identifier.episodeNumber)) {
                
                _alertUnWatched = [[UIAlertView alloc] initWithTitle:@"Attention - allready marked as seen!" message:@"you really want to unmark?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
                
                [_alertUnWatched show];
                
                return;
            }
        }
        
        _alertWatched = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"you really want to mark this episode as seen?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        
        [_alertWatched show];
    }];
}

/*!
 @discussion Auxiliary method for make one request for mark the episode as seen.
 */
- (void)watechedRequest
{
   [UsersController postWatchedEpisode:_episode.identifier finish:^(id obj) {
       
       /*
        Add this wateched episode to user in memory and update the user in DB.
        Using getUser because in the action "watched", already use the
        getUpdatedUser, so the user information is the must updated.
        */
       [_app getUser:^(User *user) {
        
           Subscription *sub = [user.subscriptions objectForKey:_episode.identifier.tvshowId];
           
           // Add the episode to subscription's watched episodes.
           [sub.episodesWatched addObject:[_episode getSynopsis]];
           
           // Increment version for cache purposes.
           user.version++;
           
           // Update in DB.
           [_app.dbController updateAsync:user];
       }];
   }];
}

/*!
 @discussion Auxiliary method for make one request for unmark the episode as seen.
 */
- (void)unWatechedRequest
{
    [UsersController deleteWatchedEpisode:_episode.identifier finish:^(id obj) {
        
        /*
         Remove this watched episode from user in memory and update the user in DB.
         Using getUser because in the action "watched", already use the
         getUpdatedUser, so the user information is the must updated.
         */
        [_app getUser:^(User *user) {
            
            Subscription *sub = [user.subscriptions objectForKey:_episode.identifier.tvshowId];
            
            // Remove the episode from subscription's watched episodes.
            EpisodeSynopsis *epiToRemove;
            for (EpisodeSynopsis *epi in sub.episodesWatched)
            {
                if ((epi.identifier.seasonNumber == _episode.identifier.seasonNumber) && (epi.identifier.episodeNumber == _episode.identifier.episodeNumber))
                {
                    epiToRemove = epi;
                    break;
                }
            }
            
            [sub.episodesWatched removeObject:epiToRemove];
            
            // Increment version for cache purposes.
            user.version++;
            
            // Update in DB.
            [_app.dbController updateAsync:user];
        }];
    }];
}

@end
