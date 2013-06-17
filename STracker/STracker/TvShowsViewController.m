//
//  ShowsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowsViewController.h"

@implementation TvShowsViewController

@synthesize title;

#pragma mark - BaseTableViewController override methods.
- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    TvShowSynopse *synopse = [_data objectAtIndex:indexPath.row];
    cell.textLabel.text = synopse.name;
}

- (void)viewDidLoadHook
{
    _numberOfSections = 1;
    self.navigationItem.title = title;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self startAnimating];
    TvShowSynopse *synopse = [_data objectAtIndex:indexPath.row];
    [[STrackerServerHttpClient sharedClient] getTvshow:synopse success:^(AFJSONRequestOperation *operation, id result) {

        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        TvShowViewController *view = [app.storyboard instantiateViewControllerWithIdentifier:@"TvShow"];
        
        view.tvshow = [[TvShow alloc] initWithDictionary:result];
        
        [self stopAnimating];
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
       
        [[STrackerServerHttpClient getAlertForError:error] show];
        [self stopAnimating];
    }];
}

@end