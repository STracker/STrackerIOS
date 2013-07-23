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
#import "ProfileViewController.h"

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
    _userName = nil;
    _body = nil;
    _userProfile = nil;
    
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
{    /*
    [[STrackerServerHttpClient sharedClient] getRequestWithHawkProtocol:_comment.user.uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        ProfileViewController *view = [[ProfileViewController alloc] initWithUser:[[User alloc] initWithDictionary:result]];
        
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
    */
}

#pragma mark - CommentViewController auxiliary private methods.

/*!
 @discussion Auxiliary method for delete the comment.
 */
- (void)deleteComment
{
    [[STrackerServerHttpClient sharedClient] deleteRequestWithHawkProtocol:_comment.uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        // Go back.
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

@end
