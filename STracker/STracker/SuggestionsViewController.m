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
    [[TvShowsController sharedObject] getTvShow:suggestion.tvshow.uri finish:^(id obj) {
        
        TvShowViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"TvShowView"] initWithTvShow:obj];
        
        [self.navigationController pushViewController:view animated:YES];
    }];
}

#pragma mark - BaseViewController abstract methods.

/*!
 @discussion In this case, the data for refreshing is the
 user information. So its needed in the end to set user
 information in App.
 */
- (void)shakeEvent
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserFriendsSuggestionsURI"];
    
    // In this moment, already have loged in, so only returns the
    // user object from App.
    [_app loginInFacebook:^(id obj) {
        
        [[UsersController sharedObject] getFriendsSuggestions:uri finish:^(id suggestions) {

            User *user = obj;
            user.suggestions = suggestions;
                
            // Set user information with new suggestions in App.
            [_app setUser:user];
                
            // Reload suggestions in table.
            _data = suggestions;
            [_tableView reloadData];
        }];
    }];
}

@end
