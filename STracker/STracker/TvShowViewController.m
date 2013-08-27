//
//  ShowViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowViewController.h"
#import "TvShow.h"
#import "Genre.h"
#import "Subscription.h"
#import "User.h"
#import "UsersRequests.h"
#import "RatingsRequests.h"
#import "UserInfoManager.h"
#import "SeasonsViewController.h"
#import "ActorsViewController.h"
#import "TvShowCommentsViewController.h"
#import "UIViewController+KNSemiModal.h"
#import "UIImageView+AFNetworking.h"
#import "SuggestViewController.h"

@implementation TvShowViewController

- (id)initWithTvShow:(TvShow *)tvshow
{
    /* 
     The [super init] is not called because this instance is 
     created from storyboard.
     */
    _tvshow = tvshow;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [self configureView];
}

- (void)viewDidUnload
{
    _airDay = nil;
    _poster = nil;
    _firstAired = nil;
    _genres = nil;
    
    _swipeGestureSeasons = nil;
    _swipeGestureDescription = nil;
    [super viewDidUnload];
}

#pragma mark - IBActions.

- (IBAction)options:(UIBarButtonItem *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Information" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Seasons", @"Cast", @"Comments", @"Subscription", @"Suggest", nil];
        
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

- (IBAction)openSeasons:(id)sender
{
    [self seasons];
}

- (IBAction)openDescription:(id)sender
{
    UITextView *text;
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        text = [[UITextView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, 300)];
        
        [text setFont:[UIFont fontWithName:@"Helvetica" size:16.0]];
    }
    else
        text = [[UITextView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, 150)];
    
    text.backgroundColor = nil;
    [text setEditable:NO];
    [text setTextAlignment:NSTextAlignmentCenter];
    [text setTextColor:[UIColor whiteColor]];
    text.text = _tvshow.description;
    
    [self presentSemiView:text];
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
            [self subscribe];
            break;
        case 4:
            [self suggestion];
            break;
    }
    
    [actionSheet setDelegate:nil];
}

#pragma mark - UIAlert View delegates.

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
    {
        if (alertView == _alertSubscribe)
            [self subscribeRequest];
    }
    
    [alertView setDelegate:nil];
    alertView = nil;
}

#pragma mark - RatingsViewController abstract methods.

- (void)postRating:(float)rating
{
    [RatingsRequests postTvShowRating:rating tvshowId:_tvshow.identifier finish:^(id obj) {
        
        // Nothing todo...
    }];
}

- (void)getRating
{
    [RatingsRequests getTvShowRating:_tvshow.identifier finish:^(id obj) {
        
        [super setRatingInfo:obj];
    }];
}

#pragma mark - TvShowViewController auxiliary private methods.

/*!
 @discussion Auxiliary method for set the television show information in 
 outlets.
 */
- (void)configureView
{
    self.navigationItem.title = _tvshow.name;
    
    _airDay.text = [NSString stringWithFormat:@"%@ / %@ minutes per episode", _tvshow.airDay, _tvshow.runtime];
    _firstAired.text = [NSString stringWithFormat:@"First aired %@", _tvshow.firstAired];
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (GenreSynopsis *genre in _tvshow.genres)
        [str appendString:[NSString stringWithFormat:@"%@\n", genre.name]];
    
    _genres.text = str;
    
    [_poster setImageWithURL:[NSURL URLWithString:_tvshow.poster]];
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

/*!
 @discussion Auxiliary method for send this suggestion to one friend.
 */
- (void)suggestion
{
    [_app.userManager getUser:^(User *user) {
        
        SuggestViewController *view = [[SuggestViewController alloc] initWithData:user.friends.allValues andTvShowId:_tvshow.identifier];
        
        [self.navigationController pushViewController:view animated:YES];
    }];
}

/*!
 @discussion Auxiliary method for subscribe or unsubscribe this tvshow. 
 */
- (void)subscribe
{
    [_app.userManager getUser:^(User *user) {
        
        if ([user.subscriptions objectForKey:_tvshow.identifier] != nil)
        {
            _alertSubscribe = [[UIAlertView alloc] initWithTitle:@"Attention!" message:@"allready subscribed!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [_alertSubscribe show];
            return;
        }
        
        _alertSubscribe = [[UIAlertView alloc] initWithTitle:@"Attention" message:[NSString stringWithFormat:@"you really want to subscribe %@?", _tvshow.name] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        
        [_alertSubscribe show];
    }];
}

/*!
 @discussion Auxiliary method for make the subscribe 
 request to STracker server.
 */
- (void)subscribeRequest
{
    [UsersRequests postSubscription:_tvshow.identifier finish:^(id obj) {
        
        // Update user info for cache purposes.
        [_app.userManager getUser:^(User *user) {
            
            Subscription *subscription = [[Subscription alloc] init];
            subscription.tvshow = (TvShowSynopsis *)[_tvshow getSynopsis];
            subscription.episodesWatched = [[NSMutableArray alloc] init];
            
            [user.subscriptions setObject:subscription forKey:_tvshow.identifier];
            
            // Save changes.
            [_app.userManager updateUser:user];
        }];
    }];
}

@end
