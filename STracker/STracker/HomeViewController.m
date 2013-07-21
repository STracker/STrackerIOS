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
#import "CurrentUserProfileViewController.h"
#import "GenresViewController.h"

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _app = [[UIApplication sharedApplication] delegate];
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
    CurrentUserProfileViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfile"];
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)searchOptions:(UIBarButtonItem *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Search" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Shows", @"Genres", @"People", nil];
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

#pragma mark - KIImagePager DataSource
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

#pragma mark - KIImagePager Delegate
- (void) imagePager:(KIImagePager *)imagePager didSelectImageAtIndex:(NSUInteger)index
{
    /*
    TvShowSynopse *synopse = [_top objectAtIndex:index];
    
    [[STrackerServerHttpClient sharedClient] getRequest:nil query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        TvShowViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"TvShow"];
        view.tvshow = [[TvShow alloc] initWithDictionary:result];
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [app getAlertViewForErrors:error.localizedDescription];
    }];
     */
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

// Auxiliary method for search series by name.
- (void) searchSeries
{
    _alertTv = [[UIAlertView alloc] initWithTitle:@"Insert the name" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Search", nil];
    _alertTv.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [_alertTv show];
}

// Auxiliary method for search series by genres, list all the genres
// available in STracker.
- (void)searchGenres
{
    GenresViewController *view = [[GenresViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

// Auxiliary method for search users by name.
- (void)searchUsers
{
    _alertUser = [[UIAlertView alloc] initWithTitle:@"Insert the name" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Search", nil];
    _alertUser.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [_alertUser show];
}

// Auxiliary method for fill tv shows with name or partial of the name
// equal to the name inserted by user.
- (void)fillTvshowsByName:(NSString *)tvName
{
    /*
    [[STrackerServerHttpClient sharedClient] getTvshowsByName:tvName success:^(AFJSONRequestOperation *operation, id result) {
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            TvShowSynopse *synopsis = [[TvShowSynopse alloc] initWithDictionary:item];
            [data addObject:synopsis];
        }
        
        TvShowsViewController *view = [[TvShowsViewController alloc] initWithData:data];
        view.title = [NSString stringWithFormat:@"Search results"];
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:nil];
     */
}

- (void)fillUsersByName:(NSString *)userName
{
    /*
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if (app.user == nil)
    {
        FacebookView *fb = [[FacebookView alloc] initWithController:self];
        [self presentSemiView:fb];
        return;
    }
    
    [[STrackerServerHttpClient sharedClient] getPeopleByName:userName success:^(AFJSONRequestOperation *operation, id result) {
        
        
        
    } failure:nil];
     */
}

#pragma mark - Alert View delegates.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
    {
        if (alertView == _alertTv)
            [self fillTvshowsByName:[[alertView textFieldAtIndex:0] text]];
        
        if (alertView == _alertUser)
            [self fillUsersByName:[[alertView textFieldAtIndex:0] text]];
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

@end