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

- (void)deleteCommentHook
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

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

#pragma mark - Alert view delegates.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
        [self deleteCommentHook];
    
    [alertView setDelegate:nil];
    alertView = nil;
}

#pragma mark - Selectors.
- (void)deleteComment
{
    _alertDelete = [[UIAlertView alloc] initWithTitle:@"Attention!" message:@"you really want to delete this comment?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    [_alertDelete show];
}

@end
