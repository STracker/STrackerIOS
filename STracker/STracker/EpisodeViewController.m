//
//  EpisodeViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "EpisodeViewController.h"
#import "DownloadFiles.h"
#import "ActorsViewController.h"
#import "STrackerServerHttpClient.h"
#import "Comment.h"
#import "EpisodeCommentsViewController.h"

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
    
    // Get rating information.
    _ratings = [[Ratings alloc] initWithAverage:_average andNumberOfUsers:_numberOfUsers];
    
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerEpisodeRatingsURI"];
    uri = [uri stringByReplacingOccurrencesOfString:@"tvshowId" withString:_episode.tvshowId];
    uri = [uri stringByReplacingOccurrencesOfString:@"seasonNumber" withString:[NSString stringWithFormat:@"%@", _episode.seasonNumber]];
    uri = [uri stringByReplacingOccurrencesOfString:@"episodeNumber" withString:[NSString stringWithFormat:@"%@", _episode.episodeNumber]];
    
    [_ratings getRating:uri];
}

- (void)viewDidUnload
{
    _poster = nil;
    _date = nil;
    _description = nil;
    _average = nil;
    _numberOfUsers = nil;
    _rating = nil;
    
    [super viewDidUnload];
}

#pragma mark - IBActions.
- (IBAction)options:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Information" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Guest Actors", @"Directors", @"Comments", nil];
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
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

#pragma mark - DLStarRatingControl delegate.

-(void)newRating:(DLStarRatingControl *)control :(float)rating
{
	NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerEpisodeRatingsURI"];
    uri = [uri stringByReplacingOccurrencesOfString:@"tvshowId" withString:_episode.tvshowId];
    uri = [uri stringByReplacingOccurrencesOfString:@"seasonNumber" withString:[NSString stringWithFormat:@"%@", _episode.seasonNumber]];
    uri = [uri stringByReplacingOccurrencesOfString:@"episodeNumber" withString:[NSString stringWithFormat:@"%@", _episode.episodeNumber]];
    
    [_ratings postRating:uri withRating:rating];
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
    _description.text = _episode.description;
    
    [[DownloadFiles sharedObject] downloadImageFromUrl:[NSURL URLWithString:_episode.poster] finish:^(UIImage *image) {
        _poster.image = image;
    }];
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
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerEpisodeCommentsURI"];
    uri = [uri stringByReplacingOccurrencesOfString:@"tvshowId" withString:_episode.tvshowId];
    uri = [uri stringByReplacingOccurrencesOfString:@"seasonNumber" withString:[NSString stringWithFormat:@"%@", _episode.seasonNumber]];
    uri = [uri stringByReplacingOccurrencesOfString:@"episodeNumber" withString:[NSString stringWithFormat:@"%@", _episode.episodeNumber]];

    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            Comment *comment = [[Comment alloc] initWithDictionary:item];
            [data addObject:comment];
        }
        
        EpisodeCommentsViewController *view = [[EpisodeCommentsViewController alloc] initWithData:data andEpisode:_episode];
        
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

@end
