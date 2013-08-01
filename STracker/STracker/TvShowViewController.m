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
#import "UIViewController+KNSemiModal.h"
#import "UsersController.h"
#import "Subscription.h"

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
    [_app loginInFacebook:^(id obj) {
        
        User *user = obj;
        Boolean exists = NO;
        // Verify if user already have this tvshow in subcriptions.
        for (Subscription *subscription in user.subscriptions)
        {
            if ([subscription.tvshow.tvshowId isEqual:_tvshow.tvshowId])
            {
                _actionSheet = [[UIActionSheet alloc] initWithTitle:@"Information" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:/*@"Seasons", */@"Cast", @"Comments", @"Unsubscribe", @"Suggest", nil];
                
                exists = YES;
                break;
            }
        }
    
        if (!exists)
            _actionSheet = [[UIActionSheet alloc] initWithTitle:@"Information" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:/*@"Seasons", */@"Cast", @"Comments", @"Subscribe", @"Suggest", nil];
        
        [_actionSheet showFromBarButtonItem:sender animated:YES];
    }];
}

- (IBAction)openSeasons:(id)sender
{
    [self seasons];
}

- (IBAction)openDescription:(id)sender
{
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, 150)];
    text.backgroundColor = nil;
    [text setEditable:NO];
    [text setTextAlignment:NSTextAlignmentCenter];
    [text setFont:[UIFont fontWithName:@"Futura Medium" size:25.0]];
    [text setTextColor:[UIColor whiteColor]];
    text.text = _tvshow.description;
    
    [self presentSemiView:text];
}

#pragma mark - Action sheet delegate.

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        /*
        case 0:
            [self seasons];
            break;
        */
        case 0:
            [self cast];
            break;
        case 1:
            [self comments];
            break;
        case 2:
            if ([[actionSheet buttonTitleAtIndex:2] isEqual:@"Subscribe"])
                [self subscribe];
            if ([[actionSheet buttonTitleAtIndex:2] isEqual:@"Unsubscribe"])
                [self unsubscribe];
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
        
        if (alertView == _alertUnsubscribe)
            [self unsubscribeRequest];
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
    
    _airDay.text = [NSString stringWithFormat:@"%@ / %@ minutes per episode", _tvshow.airDay, _tvshow.runtime];
    _firstAired.text = [NSString stringWithFormat:@"First aired %@", _tvshow.firstAired];
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (GenreSynopsis *genre in _tvshow.genres)
        [str appendString:[NSString stringWithFormat:@"%@\n", genre.name]];
    
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

/*!
 @discussion Auxiliary method for subscribe this tvshow. 
 */
- (void)subscribe
{
    // Needed to be logged to perform this action.
    [_app loginInFacebook:^(id obj) {
        
        _alertSubscribe = [[UIAlertView alloc] initWithTitle:@"Attention" message:[NSString stringWithFormat:@"you really want to subscribe %@?", _tvshow.name] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        
        [_alertSubscribe show];
    }];
}

/*!
 @discussion Auxiliary method for unsubscribe this tvshow.
 */
- (void)unsubscribe
{
    // Needed to be logged to perform this action.
    [_app loginInFacebook:^(id obj) {
        
        _alertUnsubscribe = [[UIAlertView alloc] initWithTitle:@"Attention" message:[NSString stringWithFormat:@"you really want to unsubscribe %@?", _tvshow.name] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        
        [_alertUnsubscribe show];
    }];
}

/*!
 @discussion Auxiliary method for make the subscribe 
 request to STracker server.
 */
- (void)subscribeRequest
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserSubscriptionsURI"];
    
    [[UsersController sharedObject] postFavoriteTvShow:uri tvshowId:_tvshow.tvshowId finish:^(id obj) {
        
        // Update actionsheet options to unsubscribe.
        _actionSheet = nil;
        _actionSheet = [[UIActionSheet alloc] initWithTitle:@"Information" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:/*@"Seasons", */@"Cast", @"Comments", @"Unsubscribe", @"Suggest", nil];
    }];
}

/*!
 @discussion Auxiliary method for make the unsubscribe
 request to STracker server.
 */
- (void)unsubscribeRequest
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserSubscriptionsURI"];
    
    uri = [uri stringByAppendingFormat:@"/%@", _tvshow.tvshowId];
    
    [[UsersController sharedObject] deleteFavoriteTvShow:uri finish:^(id obj) {
        
        // Update actionsheet options to unsubscribe.
        _actionSheet = nil;
        _actionSheet = [[UIActionSheet alloc] initWithTitle:@"Information" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:/*@"Seasons", */@"Cast", @"Comments", @"Subscribe", @"Suggest", nil];
    }];
}

@end
