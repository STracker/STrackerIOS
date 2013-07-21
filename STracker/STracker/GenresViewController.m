//
//  SearchByGenreViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "GenresViewController.h"
#import "STrackerServerHttpClient.h"
#import "Genre.h"
#import "TvShowsViewController.h"

@implementation GenresViewController

#pragma mark - BaseTableViewController abstract methods.
- (void)viewDidLoadHook
{
    self.navigationItem.title = @"Genres";
    
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerGenresURI"];    
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        _data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            GenreSynopse *genre = [[GenreSynopse alloc] initWithDictionary:item];
            [_data addObject:genre];
        }
        
        // Reload data of table view.
        [self.tableView reloadData];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GenreSynopse *genre = [_data objectAtIndex:indexPath.row];
    
    TvShowsViewController *view = [[TvShowsViewController alloc] initWithData:nil andSynopse:genre];
    [self.navigationController pushViewController:view animated:YES];
}

@end
