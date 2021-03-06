//
//  SuggestionsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 01/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SuggestionsViewController.h"
#import "Suggestion.h"
#import "TvShow.h"
#import "User.h"
#import "TvShowsRequests.h"
#import "TvShowViewController.h"
#import "UsersRequests.h"
#import "UserInfoManager.h"

@implementation SuggestionsViewController

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    Suggestion *suggestion = [_data objectAtIndex:indexPath.row];
    
    cell.textLabel.text = suggestion.tvshow.name;
    cell.detailTextLabel.text =[NSString stringWithFormat:@"From %@", suggestion.user.name];
}

- (void)deleteHookForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Suggestion *suggestion = [_data objectAtIndex:indexPath.row];
    
    [_data removeObjectAtIndex:indexPath.row];
    
    [UsersRequests deleteSuggestion:suggestion.tvshow.identifier finish:^(id obj) {
        
        // Search for others suggestions for same tv show.
        NSMutableArray *sugsToRemove = [[NSMutableArray alloc] init];
        for (Suggestion *sug in _data)
        {
            if ([sug.tvshow.identifier isEqualToString:suggestion.tvshow.identifier])
                [sugsToRemove addObject:sug];
        }
        
        [_data removeObjectsInArray:sugsToRemove];
        [_tableView reloadData];
        
        // Update the user information for cache purposes.
        [_app.userManager getUser:^(User *user) {
            
            user.suggestions = _data;
            [_app.userManager updateUser:user];
        }];
    }];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Suggestion *suggestion = [_data objectAtIndex:indexPath.row];
    
    [TvShowsRequests getTvShow:suggestion.tvshow.uri finish:^(id obj) {
        
        TvShowViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"TvShowView"] initWithTvShow:obj];
        
        [self.navigationController pushViewController:view animated:YES];
    }];
}

@end
