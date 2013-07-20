/*
//
//  ShowsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowsViewController.h"

@implementation TvShowsViewController

- (id)initWithData:(NSMutableArray *)data andTitle:(NSString *)title
{
    self = [super initWithData:data];
    if (self)
        _tableTitle = title;
    
    return self;
}

#pragma mark - BaseTableViewController override methods.
- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    TvShowSynopse *synopse = [_data objectAtIndex:indexPath.row];
    cell.textLabel.text = synopse.name;
}

- (void)viewDidLoadHook
{
    _numberOfSections = 1;
    self.navigationItem.title = _tableTitle;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TvShowSynopse *synopse = [_data objectAtIndex:indexPath.row];
    [[STrackerServerHttpClient sharedClient] getTvshow:synopse success:^(AFJSONRequestOperation *operation, id result) {
        
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        TvShowViewController *view = [app.storyboard instantiateViewControllerWithIdentifier:@"TvShow"];
        view.tvshow = [[TvShow alloc] initWithDictionary:result];
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:nil];
}

@end
*/