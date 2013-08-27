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
#import "EpisodesRequests.h"
#import "UsersRequests.h"
#import "UserInfoManager.h"
#import "CalendarManager.h"

@implementation UserCalendarViewController

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    UserCalendarEntry *entry = [_data objectAtIndex:indexPath.section];
    EpisodeCalendar *epiC = [entry.episodes objectAtIndex:indexPath.row];
    cell.textLabel.text = [epiC.episode constructNumber];
    cell.detailTextLabel.text = epiC.tvshowName;
}


#pragma mark - Table view data source.

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    UserCalendarEntry *entry = [_data objectAtIndex:section];
    
    return entry.date;
}

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
    
    [EpisodesRequests getEpisode:epiC.episode.uri finish:^(id obj) {
        
        EpisodeViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"EpisodeView"] initWithEpisode: obj];
        [self.navigationController pushViewController:view animated:YES];
    }];
}

#pragma mark - Shake gesture.

- (void)shakeEvent
{
    [_app.userManager.calendarManager syncUserCalendar:^(UserCalendar *calendar) {
        
        _data = (NSMutableArray *)calendar.entries;
        [_tableView reloadData];
    }];
}

@end
