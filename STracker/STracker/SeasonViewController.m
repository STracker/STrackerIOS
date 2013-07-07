//
//  SeasonViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SeasonViewController.h"

@implementation SeasonViewController

- (id)initWithData:(NSMutableArray *)data andSeasonNumber:(NSString *)seasonNumber
{
    self = [super initWithData:data];
    if (self)
        title = seasonNumber;
    
    return self;
}

#pragma mark - BaseTableViewController override methods.
- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    EpisodeSynopsis *episode = [_data objectAtIndex:indexPath.row];
    cell.textLabel.text = episode.name;
}

- (void)viewDidLoadHook
{
    _numberOfSections = 1;
    self.navigationItem.title = title;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EpisodeSynopsis *sinopsis = [_data objectAtIndex:indexPath.row];
    [[STrackerServerHttpClient sharedClient] getEpisode:sinopsis success:^(AFJSONRequestOperation *operation, id result) {
      
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        EpisodeViewController *view = [app.storyboard instantiateViewControllerWithIdentifier:@"Episode"];
        view.episode = [[Episode alloc] initWithDictionary:result];
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[STrackerServerHttpClient getAlertForError:error] show];
    }];
}

@end
