//
//  ShowsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "ShowsViewController.h"

@interface ShowsViewController ()

@end

@implementation ShowsViewController

@synthesize genre;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = genre;
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("getByGenre", nil);
    dispatch_async(downloadQueue, ^{
        InformationManager *manager = [[InformationManager alloc] init];
        
        _tvshows = [manager getShowsWithGenre:genre];
        
        // Necessário voltar a thread main para pedir para actualizar as entradas da tabela.
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tvshows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TvShowCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    // Configure the cell...
    TvShow *tvshow = [_tvshows objectAtIndex:indexPath.row];
    cell.textLabel.text = tvshow.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
