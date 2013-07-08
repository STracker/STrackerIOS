//
//  SeasonsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SeasonsViewController.h"

@implementation SeasonsViewController

#pragma mark - BaseTableViewController override methods.
- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    SeasonSynopsis *synopsis = [_data objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Season %@", synopsis.number];
}

- (void)viewDidLoadHook
{
    _numberOfSections = 1;
    self.navigationItem.title = @"Seasons";
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SeasonSynopsis *synopsis = [_data objectAtIndex:indexPath.row];
    [[STrackerServerHttpClient sharedClient] getSeason:synopsis success:^(AFJSONRequestOperation *operation, id result) {
        
        NSMutableArray *episodes = [[NSMutableArray alloc] init];
        NSDictionary *res = (NSDictionary *)result;
        for (NSDictionary *item in [res objectForKey:@"EpisodeSynopses"])
        {
            EpisodeSynopsis *episode = [[EpisodeSynopsis alloc] initWithDictionary:item];
            [episodes addObject:episode];
        }

        NSString *seasonNumber = [res objectForKey:@"SeasonNumber"];        
        SeasonViewController *view = [[SeasonViewController alloc] initWithData:episodes andSeasonNumber:[NSString stringWithFormat:@"Season %@", seasonNumber]];
        [self.navigationController pushViewController:view animated:YES];
    
    } failure:nil];
}

@end
