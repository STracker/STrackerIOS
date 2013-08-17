//
//  SearchByGenreViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "GenresViewController.h"
#import "GenresController.h"
#import "Genre.h"
#import "TvShowsViewController.h"

@implementation GenresViewController

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Open a table with tvshows synopses (all tvshows from this particular genre).
    GenreSynopsis *synopse = [_data objectAtIndex:indexPath.row];
    [GenresController getGenre:synopse.uri finish:^(Genre *genre) {
        
        TvShowsViewController *view = [[TvShowsViewController alloc] initWithData:genre.tvshows andTitle:synopse.name];
        [self.navigationController pushViewController:view animated:YES];
    }];
}

@end