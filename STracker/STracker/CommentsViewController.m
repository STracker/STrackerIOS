//
//  CommentsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CommentsViewController.h"

@implementation CommentsViewController

- (void)popupTextViewHook:(YIPopupTextView*)textView didDismissWithText:(NSString*)text cancelled:(BOOL)cancelled
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

- (void)openCommentHook:(Comment *)comment
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Reload data.
    
}

#pragma mark - Hook methods.
- (void)viewDidLoadHook
{
    self.navigationItem.title = @"Comments";
    _numberOfSections = 1;
    
    // Set right button to compose comments.
    _composeComment = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(addComment)];
    [self.navigationItem setRightBarButtonItem:_composeComment animated:YES];
}

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    Comment *comment = [_data objectAtIndex:indexPath.row];
    
    // Configure cell with comment things.
    cell.textLabel.text = comment.body;
    cell.detailTextLabel.text = comment.user.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if (app.user == nil)
    {
        FacebookView *fb = [[FacebookView alloc] initWithController:self];
        [self presentSemiView:fb];
        return;
    }
    
    [self openCommentHook:[_data objectAtIndex:indexPath.row]];
}

#pragma mark - Selectors.
- (void)addComment
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if (app.user == nil)
    {   
        FacebookView *fb = [[FacebookView alloc] initWithController:self];
        [self presentSemiView:fb];
        return;
    }
    
    [_composeComment setEnabled:NO];
    
    YIPopupTextView *popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"comment here" maxCount:0 buttonStyle:YIPopupTextViewButtonStyleRightCancelAndDone tintsDoneButton:YES];
    
    popupTextView.delegate = self;
    
    popupTextView.caretShiftGestureEnabled = YES;
    [popupTextView showInView:self.view];
}

#pragma mark - YIPopupTextView delegates.
- (void)popupTextView:(YIPopupTextView *)textView willDismissWithText:(NSString *)text cancelled:(BOOL)cancelled
{
    [_composeComment setEnabled:YES];
}

- (void)popupTextView:(YIPopupTextView*)textView didDismissWithText:(NSString*)text cancelled:(BOOL)cancelled
{
    if ([text isEqualToString:@""])
        return;
    
    [_composeComment setEnabled:YES];
    
    [self popupTextViewHook:textView didDismissWithText:text cancelled:cancelled];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];    
    UIAlertView *alertConfirm = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Hi %@", app.user.name] message:@"your comment will be processed..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];

    [alertConfirm show];
}

@end