//
//  BaseProfileViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/29/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "BaseProfileViewController.h"
#import "DownloadFiles.h"

@implementation BaseProfileViewController

/*
 This method don't call the [super init], because this controller
 is instanced from storyboard.
 */
- (id)initWithUserInfo:(User *)user
{
    _user = user;
    return self;
}

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

#pragma mark - BaseProfileViewController private auxiliary methods.

/*!
 @discussion This method sets the outlets of user basic information.
 */
- (void)fillUserInformation
{
    // Set properties of basic user information.
    _name.text = _user.name;
    
    [[DownloadFiles sharedObject] downloadImageFromUrl:[NSURL URLWithString:_user.photoUrl] finish:^(UIImage *image) {
        
        _photo.image = image;
    }];
}

@end