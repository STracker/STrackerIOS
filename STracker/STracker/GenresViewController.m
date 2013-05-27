//
//  SearchByGenreViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "GenresViewController.h"

@implementation GenresViewController

#pragma mark - BaseTableViewController override methods.
- (void)viewDidLoadHook
{
    // Nothing todo...
}

- (void)initHook
{
    _navTitle = @"Genres";
    _numberOfSections = 1;
    _cellIdentifier = @"GenreCell";
    
    _data = [[NSMutableArray alloc] initWithObjects:@"Action", @"Adventure", @"Animation", @"Biography", @"Comedy", @"Crime", @"Documentary", @"Drama", @"Family", @"Fantasy", @"Film-Noir", @"History", @"Horror", @"Music", @"Musical", @"Mystery", @"Romance", @"Sci-Fi", @"Short", @"Sport", @"Thriller", @"War", @"Western", nil];
    
}

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [_data objectAtIndex:indexPath.row];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TvShowsByGenreViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"TvShowsSynopses"];
    
    view.genre = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    
    [self.navigationController pushViewController:view animated:YES];
}

@end