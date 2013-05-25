//
//  SearchByGenreViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SearchByGenreViewController.h"

@interface SearchByGenreViewController ()

@end

@implementation SearchByGenreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    
    self.navigationItem.title = @"Genres";
    
    _genres = [[NSArray alloc] initWithObjects:@"Action", @"Adventure", @"Animation", @"Biography", @"Comedy", @"Crime", @"Documentary", @"Drama", @"Family", @"Fantasy", @"Film-Noir", @"History", @"Horror", @"Music", @"Musical", @"Mystery", @"Romance", @"Sci-Fi", @"Short", @"Sport", @"Thriller", @"War", @"Western", nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_genres count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GenreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.textLabel.text = [_genres objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowsViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"Shows"];
    view.genre = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    [self.navigationController pushViewController:view animated:YES];
}

@end
