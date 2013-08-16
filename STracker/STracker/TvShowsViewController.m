//
//  ShowsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowsViewController.h"
#import "TvShowsController.h"
#import "TvShow.h"
#import "TvShowViewController.h"

@implementation TvShowsViewController

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Open a particular tvshow controller...
    TvShowSynopsis *synopse = [_data objectAtIndex:indexPath.row];    
    [TvShowsController getTvShow:synopse.uri withVersion:nil finish:^(id obj) {
        
        TvShowViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"TvShowView"] initWithTvShow:obj];
        [self.navigationController pushViewController:view animated:YES];
    }];
}

@end