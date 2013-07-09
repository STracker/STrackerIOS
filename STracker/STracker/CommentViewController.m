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

- (void)getUserName
{
    [[STrackerServerHttpClient sharedClient] getUser:^(AFJSONRequestOperation *operation, id result) {
        
        // TODO
        
    } failure:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    _body.text = comment.body;
}

- (void)viewDidUnload
{
    _userName = nil;
    _body = nil;
    [super viewDidUnload];
}
@end
