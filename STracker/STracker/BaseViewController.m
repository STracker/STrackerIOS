//
//  BaseViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/22/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Redefine the background pattern color.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    
    _app = [[UIApplication sharedApplication] delegate];
}

@end
