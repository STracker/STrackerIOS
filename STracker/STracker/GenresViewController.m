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
#import "TvShow.h"

@implementation GenresViewController

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Open a table with tvshows synopses (all tvshows from this particular genre).
    GenreSynopse *genre = [_data objectAtIndex:indexPath.row];
    
    [[STrackerServerHttpClient sharedClient] getRequest:genre.uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            TvShowSynopse *tvshow = [[TvShowSynopse alloc] initWithDictionary:item];
            [data addObject:tvshow];
        }
        
        TvShowsViewController *view = [[TvShowsViewController alloc] initWithData:data andTitle:genre.name];
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

@end
