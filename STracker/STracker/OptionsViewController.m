//
//  OptionsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 24/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "OptionsViewController.h"

@implementation OptionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    _app = [[UIApplication sharedApplication] delegate];
    
    _profileName.text = _app.user.name;
    
    [[DownloadFiles sharedObject] downloadImageFromUrl:[NSURL URLWithString:_app.user.photoURL] finish:^(UIImage *image) {
        _profilePhoto.image = image;
        [self.tableView reloadData];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 1:
            NSLog(@"Calendar");
            break;
        case 2:
            [self subscriptions];
            break;
        case 3:
            [self friends];
            break;
    }
}

- (void)subscriptions
{
    [[STrackerServerHttpClient sharedClient] getSubscriptions:^(AFJSONRequestOperation *operation, id result) {
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result) {
            Subscription *subscription = [[Subscription alloc] initWithDictionary:item];
            [data addObject:subscription];
        }
        
        SubscriptionsViewController *view = [[SubscriptionsViewController alloc] initWithData:data];
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:nil];
}

- (void)friends
{
    
    [[STrackerServerHttpClient sharedClient] getUserFriends:^(AFJSONRequestOperation *operation, id result) {
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            UserSinospis *sinopsis = [[UserSinospis alloc] initWithDictionary:item];
            [data addObject:sinopsis];
        }
        
        UsersViewController *view = [[UsersViewController alloc] initWithData:data];
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:nil];
}

- (void)viewDidUnload {
    _profileCell = nil;
    _profilePhoto = nil;
    _profileName = nil;
    [super viewDidUnload];
}
@end
