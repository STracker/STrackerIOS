//
//  CalendarViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 24/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

- (IBAction)searchOptions:(UIBarButtonItem *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Search" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Shows", @"Genres", @"Friends", nil];
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
        [self fillTvshowsByName:[[alertView textFieldAtIndex:0] text]];

    [alertView setDelegate:nil];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _data = [[NSMutableArray alloc] initWithObjects:@"sdf", nil];
    }
    return self;
}

#pragma mark - BaseTableViewController override methods.
- (void)viewDidLoadHook
{
    self.navigationItem.title = @"Home";
}

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    TvShowSynopse *synopse = [_data objectAtIndex:indexPath.row];
    cell.textLabel.text = synopse.name;
}

#pragma mark - Action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Insert the name" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Search", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    switch (buttonIndex)
    {
        case 0:
            [alert show];
            break;
        case 1:
            [self fillGenres];
            break;
        case 2:
            [self fac];
            break;
    }
    
    [actionSheet setDelegate:nil];
}

- (void)fac
{
    FacebookViewController *fb = [[FacebookViewController alloc] init];
    [self.navigationController pushViewController:fb animated:YES];
}

- (void) getTopRated
{
    /*
    _data = [[NSMutableArray alloc] initWithObjects:@"asdasd", @"asdad", nil];
    [self startAnimating];
    [[STrackerServerHttpClient sharedClient] getTopRated:^(AFJSONRequestOperation *operation, id result) {
        _data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            TvShowSynopse *synopsis = [[TvShowSynopse alloc] initWithDictionary:item];
            [_data addObject:synopsis];
        }
        
        [self stopAnimating];
        [self.tableView reloadData];
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        [[STrackerServerHttpClient getAlertForError:error] show];
        
        [self stopAnimating];
    }];*/
    
    [[STrackerServerHttpClient sharedClient] getUserInfo:^(AFJSONRequestOperation *operation, id result) {
        NSLog(@"sucess");
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
    }];
}

- (void) fillTvshowsByName:(NSString *)name
{
    [self startAnimating];

    [[STrackerServerHttpClient sharedClient] getTvshowsByName:name success:^(AFJSONRequestOperation *operation, id result) {
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            TvShowSynopse *synopsis = [[TvShowSynopse alloc] initWithDictionary:item];
            [data addObject:synopsis];
        }
        
        [self stopAnimating];
        
        TvShowsViewController *view = [[TvShowsViewController alloc] initWithData:data];
        view.title = [NSString stringWithFormat:@"Search results"];
        [self.navigationController pushViewController:view animated:YES];

    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[STrackerServerHttpClient getAlertForError:error] show];
        [self stopAnimating];
    }];
}

- (void) fillGenres {
    
    [self startAnimating];
    
    [[STrackerServerHttpClient sharedClient] getGenres:^(AFJSONRequestOperation *operation, id result) {
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            GenreSynopsis *synopsis = [[GenreSynopsis alloc] initWithDictionary:item];
            [data addObject:synopsis];
        }
        
        [self stopAnimating];
        
        GenresViewController *view = [[GenresViewController alloc] initWithData:data];
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[STrackerServerHttpClient getAlertForError:error] show];
        [self stopAnimating];
    }];
}

@end