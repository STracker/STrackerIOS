//
//  CalendarViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 24/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "HomeViewController.h"
#import "TvShowViewController.h"
#import "MyProfileViewController.h"
#import "GenresViewController.h"
#import "TvShowsController.h"
#import "GenresController.h"
#import "UsersController.h"
#import "SearchResultsUsersViewController.h"
#import "SearchResultsTvShowsViewController.h"

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Well, without background pattern, this view stays more cool...
    self.view.backgroundColor = nil;
    
    [self getTopRated];
}

- (void)viewDidUnload
{
    _imagePager = nil;
    
    [super viewDidUnload];
}

# pragma mark - IBActions.

- (IBAction)userOptions:(id)sender
{
    [_app getUpdatedUser:^(User *user) {
        
        MyProfileViewController *view = [[self.storyboard instantiateViewControllerWithIdentifier:@"MyProfile"] initWithUserInfo:user];
        [self.navigationController pushViewController:view animated:YES];
    }];
}

- (IBAction)searchOptions:(UIBarButtonItem *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Search" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Shows", @"Genres", @"People", nil];
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

#pragma mark - KIImagePager DataSource.

- (NSArray *) arrayWithImageUrlStrings
{
    NSMutableArray *urls = [[NSMutableArray alloc] initWithCapacity:5];
    for (TvShowSynopsis *tvshow in _top)
        [urls addObject:tvshow.poster];
    
    if (urls.count == 0)
        [urls addObject:@"N/A"];
    
    return urls;
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image
{
    return UIViewContentModeScaleAspectFit;
}

#pragma mark - KIImagePager Delegate.

- (void) imagePager:(KIImagePager *)imagePager didSelectImageAtIndex:(NSUInteger)index
{
    TvShowSynopsis *synopse = [_top objectAtIndex:index];
    [TvShowsController getTvShow:synopse.uri finish:^(id obj) {
        
        TvShowViewController *view = [[self.storyboard instantiateViewControllerWithIdentifier:@"TvShowView"] initWithTvShow:obj];
        [self.navigationController pushViewController:view animated:YES];
    }];
}

#pragma mark - Action sheet delegate.

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self searchSeries];
            break;
        case 1:
            [self searchGenres];
            break;
        case 2:
            [self searchUsers];
            break;
    }
    
    [actionSheet setDelegate:nil];
}

#pragma mark - Alert View delegates.

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
    {
        if (alertView == _alertTv)
            [self searchSeriesAux:[[alertView textFieldAtIndex:0] text]];
        
        if (alertView == _alertUser)
            [self searchUsersAux:[[alertView textFieldAtIndex:0] text]];
    }
    
    [alertView setDelegate:nil];
    alertView = nil;
}

#pragma mark - BaseViewController abstract methods.

/*!
 @discussion In this case, the data for refreshing is the top television 
 shows.
 */
- (void)shakeEvent
{
    [self getTopRated];
}

#pragma mark - HomeViewController private auxiliary methods.

/*!
 @discussion This method performs a request to STracker server for 
 get the television shows with more rating.
 */
- (void)getTopRated
{
    [TvShowsController getTvShowsTopRated:^(id obj) {
        
        // Set and reload data from imagePager.
        _top = obj;
        [_imagePager reloadData];
    }];
}

/*!
 @discussion This method performs a request to STracker server for 
 get the all genres availabe.
 */
- (void)searchGenres
{
    [GenresController getGenres:^(id obj) {
        
        GenresViewController *view = [[GenresViewController alloc] initWithData:obj andTitle:@"Genres"];
        [self.navigationController pushViewController:view animated:YES];
    }];
}

/*!
 @discussion This method pop ups one alert for user insert the name 
 of the serie or series he want to search.
 */
- (void)searchSeries
{
    _alertTv = [[UIAlertView alloc] initWithTitle:@"Insert the name" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Search", nil];
    _alertTv.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [_alertTv show];
}

/*!
 @discussion This method pop ups one alert for user insert the name
 of the user he want to search.
 */
- (void)searchUsers
{
    [_app getUser:^(id obj) {
        
        _alertUser = [[UIAlertView alloc] initWithTitle:@"Insert the name of the user" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Search", nil];
        _alertUser.alertViewStyle = UIAlertViewStylePlainTextInput;
        
        [_alertUser show];
    }];
}

/*!
 @discussion This method performs a request to STracker server for get 
 the tv shows with same word on name.
 @param name The word for search.
 */
- (void)searchSeriesAux:(NSString *)name
{
    Range *range = [[Range alloc] init];
    range.start = 0;
    range.end = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerElemsPerSearch"] intValue];
    
    [TvShowsController getTvShowsByName:name withRange:range finish:^(id obj) {
        
        SearchResultsTvShowsViewController *view = [[SearchResultsTvShowsViewController alloc] initWithData:obj andTitle:name];
        [self.navigationController pushViewController:view animated:YES];
    }];
}

/*!
 @discussion This method performs a request to STracker server for get
 the users with same name.
 @param name The word for search.
 */
- (void)searchUsersAux:(NSString *)name
{
    Range *range = [[Range alloc] init];
    range.start = 0;
    range.end = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerElemsPerSearch"] intValue];
        
    [UsersController searchUser:name withRange:range finish:^(id obj) {
            
        SearchResultsUsersViewController *view = [[SearchResultsUsersViewController alloc] initWithData:obj andTitle:name];
        [self.navigationController pushViewController:view animated:YES];
    }];
}

@end