//
//  SuggestViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 18/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SuggestViewController.h"
#import "UsersController.h"
#import "User.h"

@implementation SuggestViewController

- (id)initWithData:(NSArray *)data andTvShowId:(NSString *)tvshowId
{
    if (self = [super initWithData:data])
        _tvshowId = tvshowId;
    
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserSynopsis *friend = [_data objectAtIndex:indexPath.row];
    [UsersController postSuggestion:_tvshowId forFriend:friend.identifier finish:^(id obj) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Suggestion send to %@", friend.name] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [alert show];
    }];
}

@end
