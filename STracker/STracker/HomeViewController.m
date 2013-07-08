//
//  CalendarViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 24/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

// Auxiliary method for get the top 5 tvshows.
- (void)getTopRated
{
    [[STrackerServerHttpClient sharedClient] getTopRated:^(AFJSONRequestOperation *operation, id result) {
       
        for (NSDictionary *item in result)
        {
            TvShowSynopse *synopsis = [[TvShowSynopse alloc] initWithDictionary:item];
            [_top5 addObject:synopsis];
        }
        
        [imagePager reloadData];
        
    } failure:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"STracker Top Series";
    _top5 = [[NSMutableArray alloc] initWithCapacity:5];
    
    [self getTopRated];
}

# pragma mark - IBActions.
- (IBAction)userOptions:(id)sender
{
    // Verification if the user exists, if not ask for login on Facebook.
    if (_app.user == nil)
    {
        FacebookView *fb = [[FacebookView alloc] initWithController:self];
        [self presentSemiView:fb];
        return;
    }
    
    OptionsViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"UserOptions"];
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)searchOptions:(UIBarButtonItem *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Search" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Shows", @"Genres", @"Friends", nil];
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

#pragma mark - KIImagePager DataSource
- (NSArray *) arrayWithImageUrlStrings
{
    NSMutableArray *urls = [[NSMutableArray alloc] initWithCapacity:5];
    for (TvShowSynopse *synopse in _top5)
        [urls addObject:synopse.poster];
    
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
    TvShowSynopse *synopse = [_top5 objectAtIndex:index];
    
    [[STrackerServerHttpClient sharedClient] getTvshow:synopse success:^(AFJSONRequestOperation *operation, id result) {
        
        TvShowViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"TvShow"];
        view.tvshow = [[TvShow alloc] initWithDictionary:result];
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:nil];
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Insert the name" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Search", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alert show];
}

// Auxiliary method for search series by genres, list all the genres
// available in STracker.
- (void)searchGenres
{
    [[STrackerServerHttpClient sharedClient] getGenres:^(AFJSONRequestOperation *operation, id result) {
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            GenreSynopsis *synopsis = [[GenreSynopsis alloc] initWithDictionary:item];
            [data addObject:synopsis];
        }
        GenresViewController *view = [[GenresViewController alloc] initWithData:data];
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:nil];
}

// Auxiliary method for search users by name.
- (void)searchUsers
{
    // TODO
}

// Auxiliary method for fill tv shows with name or partial of the name
// equal to the name inserted by user.
- (void)fillTvshowsByName:(NSString *)tvName
{
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
}

#pragma mark - Alert View delegates.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
        [self fillTvshowsByName:[[alertView textFieldAtIndex:0] text]];
    
    [alertView setDelegate:nil];
    alertView = nil;
}

- (void)viewDidUnload
{
    imagePager = nil;
    [super viewDidUnload];
}
@end