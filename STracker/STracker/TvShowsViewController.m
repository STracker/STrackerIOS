//
//  ShowsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowsViewController.h"
#import "STrackerServerHttpClient.h"
#import "TvShow.h"
#import "TvShowViewController.h"

@implementation TvShowsViewController

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Open a particular tvshow controller...
    TvShowSynopse *synopse = [_data objectAtIndex:indexPath.row];
    
    [[STrackerServerHttpClient sharedClient] getRequest:synopse.uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        TvShow *tvshow = [[TvShow alloc] initWithDictionary:result];
        TvShowViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"TvShow"] initWithTvShow:tvshow];
        
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

@end