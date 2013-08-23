//
//  SubscriptionViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 8/23/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SubscriptionViewController.h"
#import "TvShowsController.h"
#import "EpisodesController.h"
#import "TvShowViewController.h"
#import "EpisodeViewController.h"

@implementation SubscriptionViewController

- (id)initWithSubscription:(Subscription *)subscription
{
    // Reverse order for show the newest watched episodes first.
    if (self = [super initWithData:[[subscription.episodesWatched reverseObjectEnumerator] allObjects] andTitle:subscription.tvshow.name])
        _subscription = subscription;
    
    return self;
}

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        cell.textLabel.text = _subscription.tvshow.name;
        return;
    }
    
    EpisodeSynopsis *episode = [_data objectAtIndex:indexPath.row];
    
    NSString *seasonN;
    if (episode.identifier.seasonNumber < 9)
        seasonN = [NSString stringWithFormat:@"S0%d", episode.identifier.seasonNumber];
    else
        seasonN = [NSString stringWithFormat:@"S%d", episode.identifier.seasonNumber];
    
    NSString *episodeN;
    if (episode.identifier.episodeNumber < 9)
        episodeN = [NSString stringWithFormat:@"E0%d", episode.identifier.episodeNumber];
    else
        episodeN = [NSString stringWithFormat:@"E%d", episode.identifier.episodeNumber];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@%@ - %@",seasonN, episodeN, episode.name];
    
    cell.detailTextLabel.text = episode.date;
}

#pragma mark - Table view data source.

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1)
        return [NSString stringWithFormat:@"%d episode(s) watched", _data.count];
    
    return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 1;
    
    return [_data count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [TvShowsController getTvShow:_subscription.tvshow.uri finish:^(id obj) {
            
            TvShowViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"TvShowView"] initWithTvShow:obj];
            
            [self.navigationController pushViewController:view animated:YES];
        }];
        
        return;
    }
    
    EpisodeSynopsis *episode = [_data objectAtIndex:indexPath.row];
    
    [EpisodesController getEpisode:episode.uri finish:^(id obj) {
        
        EpisodeViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"EpisodeView"] initWithEpisode: obj];
        
        [self.navigationController pushViewController:view animated:YES];
    }];
}

@end
