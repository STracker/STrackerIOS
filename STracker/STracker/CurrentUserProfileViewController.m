//
//  CurrentUserProfileViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 21/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CurrentUserProfileViewController.h"
#import "DownloadFiles.h"

@implementation CurrentUserProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self fillUserInformation];
}

- (void)viewDidUnload
{
    _photo = nil;
    _name = nil;
    
    [super viewDidUnload];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 1:
            [self calendar];
            break;
        case 2:
            [self subscriptions];
            break;
        case 3:
            [self friends];
            break;
        case 4:
            [self messages];
            break;
    }
}

#pragma mark - CurrentUserProfileViewController private auxiliary methods.

/*!
 @discussion This method opens a table with the calendar of next episodes from user's 
 favorite shows.
 */
- (void)calendar
{
    //TODO
}

/*!
 @discussion This method opens a table with user's subscriptions.
 */
- (void)subscriptions
{
    //TODO
}

/*!
 @discussion This method opens a table with user's friends.
 */
- (void)friends
{
    //TODO
}

/*!
 @discussion This method opens a table with user's messages.
 */
- (void)messages
{
    //TODO
}

/*!
 @discussion This method get the user information in AppDelegate, if the information
 already exists, fill the outlets, if not, user will see a prompt with Facebook Login. 
 (This logic it's implemented in AppDelegate).
 */
- (void)fillUserInformation
{
    _app = [[UIApplication sharedApplication] delegate];
    [_app loginInFacebook:^(User *user) {
        
        _user = user;
        
        // Set properties of basic user information.
        _name.text = _user.name;
        
        [[DownloadFiles sharedObject] downloadImageFromUrl:[NSURL URLWithString:_user.photoUrl] finish:^(UIImage *image) {
            
            _photo.image = image;
        }];
    }];
}

@end
