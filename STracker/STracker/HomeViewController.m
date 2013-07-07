//
//  CalendarViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 24/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

# pragma mark - BaseTableViewController override methods.
- (void)viewDidLoadHook
{
    self.navigationItem.title = @"Home";
    _app = [[UIApplication sharedApplication] delegate];
}

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    TvShowSynopse *synopse = [_data objectAtIndex:indexPath.row];
    cell.textLabel.text = synopse.name;
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
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[STrackerServerHttpClient getAlertForError:error] show];
    }];
}

// Auxiliary method for search users by name.
- (void)searchUsers
{
    SlideshowViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"Profile"];
    [self.navigationController pushViewController:view animated:YES];
}

// Auxiliary method for fill tv shows with name or partial of the name
// equal to the name inserted by user.
- (void)fillTvshowsByName:(NSString *)name
{
    [[STrackerServerHttpClient sharedClient] getTvshowsByName:name success:^(AFJSONRequestOperation *operation, id result) {
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            TvShowSynopse *synopsis = [[TvShowSynopse alloc] initWithDictionary:item];
            [data addObject:synopsis];
        }
        
        TvShowsViewController *view = [[TvShowsViewController alloc] initWithData:data];
        view.title = [NSString stringWithFormat:@"Search results"];
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[STrackerServerHttpClient getAlertForError:error] show];
    }];
}

#pragma mark - Alert View delegates.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
        [self fillTvshowsByName:[[alertView textFieldAtIndex:0] text]];
    
    [alertView setDelegate:nil];
    alertView = nil;
}

@end