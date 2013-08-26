//
//  SeasonsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SeasonsViewController.h"
#import "SeasonsRequests.h"
#import "Season.h"
#import "SeasonViewController.h"

@implementation SeasonsViewController

#pragma mark - Table view delegate.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SeasonSynopsis *synopsis = [_data objectAtIndex:indexPath.row];
    
    [SeasonsRequests getSeason:synopsis.uri finish:^(Season *season) {
        
        SeasonViewController *view = [[SeasonViewController alloc] initWithData:season.episodes andTitle:synopsis.name];
        [self.navigationController pushViewController:view animated:YES];
    }];
}

@end