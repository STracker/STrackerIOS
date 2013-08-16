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
    _ratingsUri = [_ratingsUri stringByReplacingOccurrencesOfString:@"id" withString:_tvshow.identifier];

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
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Information" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:/*@"Seasons", */@"Cast", @"Comments", @"Subscription", @"Suggest", nil];
        
    [actionSheet showFromBarButtonItem:sender animated:YES];
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
            [self subscribe];
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
 @discussion Auxiliary method for subscribe or unsubscribe this tvshow. 
 */
- (void)subscribe
{
    // Needed to be logged to perform this action.
    [_app getUpdatedUser:^(User *user) {
        
        for (Subscription *sub in user.subscriptions)
        {
            if ([sub.tvshow.identifier isEqualToString:_tvshow.identifier])
            {
                _alertUnsubscribe = [[UIAlertView alloc] initWithTitle:@"Attention - allready subscribed!" message:[NSString stringWithFormat:@"you really want to unsubscribe %@?", _tvshow.name] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
                
                [_alertUnsubscribe show];
                
                return;
            }
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
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserSubscriptionsURI"];
    
    [UsersController postFavoriteTvShow:uri tvshowId:_tvshow.identifier finish:^(id obj) {
        
        
    }];
}

/*!
 @discussion Auxiliary method for make the unsubscribe
 request to STracker server.
 */
- (void)unsubscribeRequest
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserSubscriptionsURI"];
    uri = [uri stringByAppendingFormat:@"/%@", _tvshow.identifier];
    
    [UsersController deleteFavoriteTvShow:uri finish:^(id obj) {
        
        /*
        User *user = [_app getUser];
        Subscription *subToRemove;
        for (Subscription *sub in user.subscriptions)
        {
            if ([sub.tvshow.identifier isEqualToString:_tvshow.identifier])
            {
                subToRemove = sub;
                break;
            }
        }
        
        if (subToRemove == nil)
            return;
        
        // Remove subscription from list and increment the version, for use the cache control.
        [user.subscriptions removeObject:subToRemove];
        user.version++;
         */
    }];
}

@end
