//
//  UserCalendarViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 8/22/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "UserCalendarViewController.h"
#import "UserCalendar.h"
#import "Episode.h"
#import "EpisodeViewController.h"
#import "EpisodesController.h"
#import "UsersController.h"

@implementation UserCalendarViewController

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    UserCalendarEntry *entry = [_data objectAtIndex:indexPath.section];
    EpisodeCalendar *epiC = [entry.episodes objectAtIndex:indexPath.row];
    
    NSString *seasonN;
    if (epiC.episode.identifier.seasonNumber < 9)
        seasonN = [NSString stringWithFormat:@"S0%d", epiC.episode.identifier.seasonNumber];
    else
        seasonN = [NSString stringWithFormat:@"S%d", epiC.episode.identifier.seasonNumber];
    
    NSString *episodeN;
    if (epiC.episode.identifier.episodeNumber < 9)
        episodeN = [NSString stringWithFormat:@"E0%d", epiC.episode.identifier.episodeNumber];
    else
        episodeN = [NSString stringWithFormat:@"E%d", epiC.episode.identifier.episodeNumber];
        
    cell.textLabel.text = [NSString stringWithFormat:@"%@%@ - %@",seasonN, episodeN, epiC.episode.name];
    cell.detailTextLabel.text = epiC.tvshowName;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    UserCalendarEntry *entry = [_data objectAtIndex:section];
    
    return entry.date;
}

#pragma mark - Table view data source.

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    UserCalendarEntry *entry = [_data objectAtIndex:section];
    return [entry.episodes count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserCalendarEntry *entry = [_data objectAtIndex:indexPath.section];
    EpisodeCalendar *epiC = [entry.episodes objectAtIndex:indexPath.row];
    
    [EpisodesController getEpisode:epiC.episode.uri finish:^(id obj) {
        
        EpisodeViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"EpisodeView"] initWithEpisode: obj];
        [self.navigationController pushViewController:view animated:YES];
    }];
}

#pragma mark - Shake gesture.

- (void)shakeEvent
{
    [UsersController getUserCalendar:^(UserCalendar *calendar) {
        
        _data = (NSMutableArray *)calendar.entries;
        [_tableView reloadData];
        
        [_app getUser:^(User *me) {
            
            me.calendar = calendar;
            
            // Update in DB.
            [_app.dbController updateAsync:me];
        }];
    }];
}

@end
