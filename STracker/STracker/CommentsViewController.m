//
//  CommentsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CommentsViewController.h"
#import "Comment.h"
#import "CommentViewController.h"

@implementation CommentsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set right button to compose comments.
    _composeComment = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(addComment)];
    [self.navigationItem setRightBarButtonItem:_composeComment animated:YES];
    
    _commentController = [[CommentController alloc] init];
    
    [_commentController getComments:_commentsUri finish:^(NSArray *comments) {
        // Set and reload table's data.
        _data = comments;
        [self.tableView reloadData];
    }];
}

- (void)popupTextViewHook:(NSString *)text
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

#pragma mark - BaseTableViewController abstract methods.

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    Comment *comment = [_data objectAtIndex:indexPath.row];
    
    // Configure cell with comment things.
    cell.textLabel.text = comment.body;
    cell.detailTextLabel.text = comment.user.name;
}

#pragma mark - Table view delegate.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Comment *comment = [_data objectAtIndex:indexPath.row];
    
    // Needed to be Logged in Facebook to view the comment.
    [_app loginInFacebook:^(User *user) {
        
        CommentViewController *view = [[_app.storyboard instantiateViewControllerWithIdentifier:@"CommentView"] initWithComment:comment];
        [self.navigationController pushViewController:view animated:YES];
    }];
}

#pragma mark - Selectors.

- (void)addComment
{
    // Needed to be Logged in Facebook to create an comment.
    [_app loginInFacebook:^(User *user) {
        
        [_composeComment setEnabled:NO];
        YIPopupTextView *popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"comment here" maxCount:0 buttonStyle:YIPopupTextViewButtonStyleRightCancelAndDone tintsDoneButton:YES];
        
        popupTextView.delegate = self;
        popupTextView.caretShiftGestureEnabled = YES;
        [popupTextView showInView:self.view];
    }];
}

#pragma mark - YIPopupTextView delegates.

- (void)popupTextView:(YIPopupTextView *)textView willDismissWithText:(NSString *)text cancelled:(BOOL)cancelled
{
    [_composeComment setEnabled:YES];
}

- (void)popupTextView:(YIPopupTextView*)textView didDismissWithText:(NSString*)text cancelled:(BOOL)cancelled
{
    if ([text isEqualToString:@""] || cancelled)
        return;
    
    [_composeComment setEnabled:YES];
    
    // Post comment to STracker server.
    [_commentController postComment:_commentsUri comment:text];
}

@end