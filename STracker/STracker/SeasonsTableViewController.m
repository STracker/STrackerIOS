//
//  SeasonsTableViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 09/04/13.
//  Copyright (c) 2013 Ricardo Sousa. All rights reserved.
//

#import "SeasonsTableViewController.h"

@implementation SeasonsTableViewController

@synthesize Seasons;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Seasons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"season_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    Season *season = [Seasons objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Season number: %d", season.Number];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://strackerserverdev.apphb.com/api/tvshows/tt1520211/seasons/%d", indexPath.row+1]];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSError *error = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    Season *season;
    
    if (!result)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error retrieving data" message:nil delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        season = [Seasons objectAtIndex:indexPath.row];
        season.Episodes = [[NSMutableArray alloc] init];
        
        for(NSDictionary *item in [result objectForKey:@"EpisodeSynopses"])
        {
            Episode *epi = [[Episode alloc] init];
            [epi setName:[item objectForKey:@"Name"]];
            [season.Episodes addObject:epi];
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        EpisodeTableViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"EpisodesTable"];
        
        view.Episodes = season.Episodes;
        
        [self.navigationController pushViewController:view animated:YES];
        
    });
}

@end
