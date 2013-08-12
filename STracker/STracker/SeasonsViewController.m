//
//  SeasonsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SeasonsViewController.h"
#import "SeasonsController.h"
#import "Season.h"
#import "SeasonViewController.h"

@implementation SeasonsViewController

#pragma mark - Table view delegate.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SeasonSynopsis *synopse = [_data objectAtIndex:indexPath.row];
    [SeasonsController getSeason:synopse.uri finish:^(id obj) {
        
        Season *season = obj;
        SeasonViewController *view = [[SeasonViewController alloc] initWithData:season.episodes andTitle:synopse.name];
        [self.navigationController pushViewController:view animated:YES];
    }];
}

@end