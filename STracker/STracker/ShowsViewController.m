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

- (void)getShows
{
    NSURL *url = [InfoDownloadManager contructUrlWithPath:@"/api/tvhows" andQuery:[NSString stringWithFormat:@"genre=%@", genre]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    [InfoDownloadManager performDownloadWithRequest:request andCallback:^(NSData *data, int statusCode, NSError *error)
    {
        if (!error) {
            _tvshows = [[NSMutableArray alloc] init];
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                return;
            }
            
            for (NSDictionary *item in result) {
                TvShowSynopse *synopse = [[TvShowSynopse alloc] init];
                synopse.imdbId = [item objectForKey:@"Id"];
                synopse.name = [item objectForKey:@"Name"];
                
                [_tvshows addObject: synopse];
            }

        }
        
        dispatch_async(dispatch_get_main_queue(), ^()
        {
            if (!error)
            {
                [self.tableView reloadData];
                return;
            }
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        });
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = genre;
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    
    [self getShows];
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
