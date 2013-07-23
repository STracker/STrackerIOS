//
//  SeasonViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SeasonViewController.h"
#import "Episode.h"
#import "EpisodeViewController.h"
#import "STrackerServerHttpClient.h"

@implementation SeasonViewController

#pragma mark - Table view delegate.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Opens an particular episode.
    EpisodeSynopse *synopse = [_data objectAtIndex:indexPath.row];
    
    [[STrackerServerHttpClient sharedClient] getRequest:synopse.uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        Episode *episode = [[Episode alloc] initWithDictionary:result];
        
        EpisodeViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"EpisodeView"] initWithEpisode: episode];
        
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [_app getAlertViewForErrors:error.localizedDescription];
    }];
}

@end