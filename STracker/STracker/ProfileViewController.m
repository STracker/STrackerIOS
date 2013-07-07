//
//  ProfileViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 07/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "ProfileViewController.h"

@implementation ProfileViewController

- (void)getPhoto
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicator setCenter:photo.center];
    [photo addSubview:indicator];
    
    [indicator startAnimating];
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("getImage", nil);
    dispatch_async(downloadQueue, ^{
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", _app.user.identifier]]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            photo.image = img;
            [indicator stopAnimating];
        });
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    
    _app = [[UIApplication sharedApplication] delegate];
    
    name.text = _app.user.name;
    
    [self getPhoto];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    photo = nil;
    name = nil;
    [super viewDidUnload];
}
@end
