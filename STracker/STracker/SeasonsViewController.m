//
//  SeasonsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SeasonsViewController.h"
#import "STrackerServerHttpClient.h"
#import "Season.h"
#import "Episode.h"
#import "SeasonViewController.h"

@implementation SeasonsViewController

#pragma mark - Table view delegate.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SeasonSynopse *synopse = [_data objectAtIndex:indexPath.row];
    [[STrackerServerHttpClient sharedClient] getRequest:synopse.uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [result objectForKey:@"EpisodeSynopses"])
        {
            EpisodeSynopse *episode = [[EpisodeSynopse alloc] initWithDictionary:item];
            [data addObject:episode];
        }
        
        SeasonViewController *view = [[SeasonViewController alloc] initWithData:data andTitle:[NSString stringWithFormat:@"Season %@", [result objectForKey:@"SeasonNumber"]]];
        
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [_app getAlertViewForErrors:error.localizedDescription];
    }];
}

@end