//
//  ShowsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowsViewController.h"

@implementation TvShowsViewController

- (void)fillTable:(NSDictionary *)data
{
    _data = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in data)
        [_data addObject:[[TvShowSynopse alloc] initWithDictionary:item]];
    
    [self.tableView reloadData];
}

- (void)failure:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alert show];
}

#pragma mark - BaseTableViewController override methods.
- (void)initHook
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

- (void)viewDidLoadHook
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    TvShowSynopse *synopse = [_data objectAtIndex:indexPath.row];
    cell.textLabel.text = synopse.name;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TvShowViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowView"];
    
    TvShowSynopse *synopse = [_data objectAtIndex:indexPath.row];
    view.imdbId = synopse.imdbId;
    
    [self.navigationController pushViewController:view animated:YES];
}

@end
