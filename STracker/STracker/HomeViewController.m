//
//  CalendarViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 24/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "HomeViewController.h"
#import "STrackerServerHttpClient.h"
#import "TvShow.h"
#import "TvShowsViewController.h"
#import "MyProfileViewController.h"
#import "GenresViewController.h"
#import "Genre.h"
#import "TvShowViewController.h"

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Well, without background pattern in this view, gets more cool...
    self.view.backgroundColor = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    // For this action is necessary the user was logged into Facebook account.
    [_app loginInFacebook:^(User *user) {
        
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
    for (TvShowSynopse *tvshow in _top)
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
    TvShowSynopse *synopse = [_top objectAtIndex:index];
    
    [[STrackerServerHttpClient sharedClient] getRequest:synopse.uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        TvShow *tvshow = [[TvShow alloc] initWithDictionary:result];
        TvShowViewController *view = [[self.storyboard instantiateViewControllerWithIdentifier:@"TvShow"] initWithTvShow:tvshow];
        
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
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

#pragma mark - HomeViewController private auxiliary methods.

/*!
 @discussion This method performs a request to STracker server for 
 get the television shows with more rating.
 */
- (void)getTopRated
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerTopRatedTvShowsURI"];
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        _top = nil;
        _top = [[NSMutableArray alloc] initWithCapacity:(int)[[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerTopTvShowsNumber"]];
        
        for (NSDictionary *item in result)
        {
            TvShowSynopse *synopsis = [[TvShowSynopse alloc] initWithDictionary:item];
            [_top addObject:synopsis];
        }
        
        [_imagePager reloadData];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {

        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

/*!
 @discussion This method performs a request to STracker server for 
 get the all genres availabe.
 */
- (void)searchGenres
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerGenresURI"];
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            GenreSynopse *genre = [[GenreSynopse alloc] initWithDictionary:item];
            [data addObject:genre];
        }
        
        GenresViewController *view = [[GenresViewController alloc] initWithData:data andTitle:@"Genres"];
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

/*!
 @discussion This method pop ups one alert for user insert the name 
 of the serie or series he want to search.
 */
- (void)searchSeries
{
    _alertTv = [[UIAlertView alloc] initWithTitle:@"Insert the name of the tv show" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Search", nil];
    _alertTv.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [_alertTv show];
}

/*!
 @discussion This method pop ups one alert for user insert the name
 of the user he want to search.
 */
- (void)searchUsers
{
    _alertUser = [[UIAlertView alloc] initWithTitle:@"Insert the name of the user" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Search", nil];
    _alertUser.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [_alertUser show];
}

/*!
 @discussion This method performs a request to STracker server for get 
 the tv shows with same word on name.
 @param name The word for search.
 */
- (void)searchSeriesAux:(NSString *)name
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerTvShowsURI"];
    NSDictionary *query = [[NSDictionary alloc] initWithObjectsAndKeys:name, @"name", nil];
    
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:query success:^(AFJSONRequestOperation *operation, id result) {
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            TvShowSynopse *tvshow = [[TvShowSynopse alloc] initWithDictionary:item];
            [data addObject:tvshow];
        }
        
        TvShowsViewController *view = [[TvShowsViewController alloc] initWithData:data];
        [self.navigationController pushViewController:view animated:YES];
     
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

/*!
 @discussion This method performs a request to STracker server for get
 the users with same name.
 @param name The word for search.
 */
- (void)searchUsersAux:(NSString *)name
{
    // TODO.
}

@end