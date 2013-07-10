//
//  OptionsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 24/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "OptionsViewController.h"

@implementation OptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    
    _app = [[UIApplication sharedApplication] delegate];
    
    self.navigationItem.title = _app.user.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            NSLog(@"Calendar");
            break;
        case 1:
            [self subscriptions];
            break;
        case 2:
            [self friends];
            break;
    }
}

- (void)subscriptions
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if (app.user == nil)
    {
        FacebookView *fb = [[FacebookView alloc] initWithController:self];
        [self presentSemiView:fb];
        return;
    }
    
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
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if (app.user == nil)
    {
        FacebookView *fb = [[FacebookView alloc] initWithController:self];
        [self presentSemiView:fb];
        return;
    }
    
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

@end
