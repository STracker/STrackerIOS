//
//  CommentViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CommentViewController.h"

@implementation CommentViewController

@synthesize comment;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    _body.text = comment.body;
    _userName.text = comment.user.name;
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    if (![comment.user.identifier isEqualToString:app.user.identifier])
        return;
    
    // If the comment is from the current user, add the delete option.
    UIBarButtonItem *bt = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteComment)];
    [self.navigationItem setRightBarButtonItem:bt animated:YES];
}

- (void)viewDidUnload
{
    _userName = nil;
    _body = nil;
    _userProfile = nil;
    [super viewDidUnload];
}

#pragma mark - UIAlertView delegates.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
    {
        [[STrackerServerHttpClient sharedClient] deleteComment:comment success:^(AFJSONRequestOperation *operation, id result) {
            
            // Go back.
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:nil];
    }
    
    [alertView setDelegate:nil];
    alertView = nil;
}

#pragma mark - Selectors.
- (void)deleteComment
{
    _alertDelete = [[UIAlertView alloc] initWithTitle:@"Attention!" message:@"you really want to delete this comment?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    [_alertDelete show];
}

- (IBAction)openUserProfile
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if ([app.user.identifier isEqualToString:comment.user.identifier])
        return;
    
    [[STrackerServerHttpClient sharedClient] getUser:comment.user.identifier success:^(AFJSONRequestOperation *operation, id result) {
        
        User *user = [[User alloc] initWithDictionary:result];
        
        ProfileViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"Profile"];
        view.user = user;
        
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:nil];
}

@end
