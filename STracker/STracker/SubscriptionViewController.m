//
//  SubscriptionViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 8/23/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SubscriptionViewController.h"
#import "Subscription.h"
#import "TvShowsRequests.h"
#import "EpisodesRequests.h"
#import "TvShowViewController.h"
#import "EpisodeViewController.h"
#import "Episode.h"
#import "TvShow.h"

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
    cell.textLabel.text = [episode constructNumber];
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
        [TvShowsRequests getTvShow:_subscription.tvshow.uri finish:^(id obj) {
            
            TvShowViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"TvShowView"] initWithTvShow:obj];
            
            [self.navigationController pushViewController:view animated:YES];
        }];
        
        return;
    }
    
    EpisodeSynopsis *episode = [_data objectAtIndex:indexPath.row];
    
    [EpisodesRequests getEpisode:episode.uri finish:^(id obj) {
        
        EpisodeViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"EpisodeView"] initWithEpisode: obj];
        
        [self.navigationController pushViewController:view animated:YES];
    }];
}

@end
