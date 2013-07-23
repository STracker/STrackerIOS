/*
//
//  ProfileViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 10/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "ProfileViewController.h"

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    
    self.navigationItem.title = self.user.name;
    
    _numberOfSubscriptions.text = [NSString stringWithFormat:@"%d shows", self.user.subscriptions.count];
    
    [[DownloadFiles sharedObject] downloadImageFromUrl:[NSURL URLWithString:self.user.photoURL] finish:^(UIImage *image) {
        
        _photo.image = image;
    }];
    
}

- (void)viewDidUnload
{
    _photo = nil;
    _numberOfSubscriptions = nil;
    [super viewDidUnload];
}

- (IBAction)options:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"See" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Following", @"Friends", nil];
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

- (IBAction)invite
{
    [[STrackerServerHttpClient sharedClient] postInvite:self.user success:^(AFJSONRequestOperation *operation, id result) {
        
        // TODO...
        
    } failure:nil];
}

#pragma mark - Action sheet delegate.
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self subscriptions];
            break;
        case 1:
            [self friends];
    }
    
    [actionSheet setDelegate:nil];
}

- (void)subscriptions
{
    SubscriptionsViewController *view = [[SubscriptionsViewController alloc] initWithData:self.user.subscriptions];
    
    [self.navigationController pushViewController:view animated:YES];
}

- (void)friends
{
    UsersViewController *view = [[UsersViewController alloc] initWithData:self.user.friends];
    [self.navigationController pushViewController:view animated:YES];
}

@end
*/
