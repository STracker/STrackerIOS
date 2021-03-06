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
#import "EpisodesRequests.h"

@implementation SeasonViewController

/*
 Override configure cell hook method for change the title of the cells.
 */
- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    EpisodeSynopsis *episode = [_data objectAtIndex:indexPath.row];
    cell.textLabel.text = [episode constructNumber];
}

#pragma mark - Table view delegate.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Opens an particular episode.
    EpisodeSynopsis *synopsis = [_data objectAtIndex:indexPath.row];
    
    [EpisodesRequests getEpisode:synopsis.uri finish:^(id obj) {
        EpisodeViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"EpisodeView"] initWithEpisode: obj];
        
        [self.navigationController pushViewController:view animated:YES];
    }];
}

@end