//
//  SearchByGenreViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "GenresViewController.h"

@implementation GenresViewController

#pragma mark - BaseTableViewController override methods.
- (void)viewDidLoadHook
{
    self.navigationItem.title = @"Genres";
    _numberOfSections = 1;
}

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    GenreSynopsis *synopsis = [_data objectAtIndex:indexPath.row];
    cell.textLabel.text = [synopsis.name capitalizedString];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get all tvshows from this selected genre.
    [[STrackerServerHttpClient sharedClient] getTvShowsByGenre:[_data objectAtIndex:indexPath.row] success:^(AFJSONRequestOperation *operation, id result) {
        
        NSMutableArray *data = [[NSMutableArray alloc] init];        
        for (NSDictionary *item in result)
        {
            TvShowSynopse *synopse = [[TvShowSynopse alloc] initWithDictionary:item];
            [data addObject:synopse];
        }
        
        GenreSynopsis *synopsis = [_data objectAtIndex:indexPath.row];
        TvShowsViewController *view = [[TvShowsViewController alloc] initWithData:data andGenre:synopsis.name];
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[STrackerServerHttpClient getAlertForError:error] show];
    }];
}

@end