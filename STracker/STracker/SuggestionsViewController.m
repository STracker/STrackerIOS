//
//  SuggestionsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 01/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SuggestionsViewController.h"
#import "Suggestion.h"
#import "TvShowsController.h"
#import "TvShowViewController.h"
#import "UsersController.h"

@implementation SuggestionsViewController

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    Suggestion *suggestion = [_data objectAtIndex:indexPath.row];
    
    cell.textLabel.text = suggestion.tvshow.name;
    cell.detailTextLabel.text =[NSString stringWithFormat:@"From %@", suggestion.user.name];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Suggestion *suggestion = [_data objectAtIndex:indexPath.row];
    
    [TvShowsController getTvShow:suggestion.tvshow.uri withVersion:nil finish:^(id obj) {
        
        TvShowViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"TvShowView"] initWithTvShow:obj];
        
        [self.navigationController pushViewController:view animated:YES];
    }];
}

@end
