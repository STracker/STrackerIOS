//
//  CommentViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CommentViewController.h"
#import "STrackerServerHttpClient.h"
#import "User.h"
#import "CommentController.h"
#import "UserProfileViewController.h"
#import "UsersController.h"

@implementation CommentViewController

- (id)initWithComment:(Comment *)comment
{
    /*
     The [super init] is not called because this instance is
     created from storyboard.
     */
    _comment = comment;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _body.text = _comment.body;
    _userName.text = _comment.user.name;

    [_app loginInFacebook:^(User *user) {

        if ([user.identifier isEqualToString:_comment.user.identifier])
        {
            // If the comment is from the current user, add the delete option.
            UIBarButtonItem *bt = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteCommentSelector)];
            
            [self.navigationItem setRightBarButtonItem:bt animated:YES];
        }
    }];
}

- (void)viewDidUnload
{
    _body = nil;
    _userProfile = nil;
    
    _userName = nil;
    [super viewDidUnload];
}

#pragma mark - UIAlertView delegates.

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
        [self deleteComment];
    
    [alertView setDelegate:nil];
    alertView = nil;
}

#pragma mark - Selectors.

- (void)deleteCommentSelector
{
    _alertDelete = [[UIAlertView alloc] initWithTitle:@"Attention!" message:@"you really want to delete this comment?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    [_alertDelete show];
}

#pragma mark - IBActions.

- (IBAction)openUserProfile
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUsersURI"];
    uri = [uri stringByAppendingString:[NSString stringWithFormat:@"/%@", _comment.user.identifier]];
    
    [[UsersController sharedObject] getUser:uri finish:^(id obj) {
        
        UserProfileViewController *view = [[self.storyboard instantiateViewControllerWithIdentifier:@"UserProfile"] initWithUserInfo:obj];
        [self.navigationController pushViewController:view animated:YES];
    }];
}

#pragma mark - CommentViewController auxiliary private methods.

/*!
 @discussion Auxiliary method for delete the comment.
 */
- (void)deleteComment
{
    [[CommentController sharedObject] deleteComment:_comment.uri finish:^(id obj) {
        
        // Go back.
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
