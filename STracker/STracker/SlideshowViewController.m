//
//  ProfileViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 07/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SlideshowViewController.h"

@implementation SlideshowViewController

@synthesize items;

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
}

- (void)viewDidUnload {
    imagePager = nil;
    title = nil;
    [super viewDidUnload];
}

#pragma mark - KIImagePager DataSource
- (NSArray *) arrayWithImageUrlStrings
{
    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:items.count];
    
    for (TvShow *tv in items) 
        [images addObject:tv.poster];
    
    return images;
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image
{
    return UIViewContentModeScaleAspectFit;
}

#pragma mark - KIImagePager Delegate
- (void) imagePager:(KIImagePager *)imagePager didScrollToIndex:(NSUInteger)index
{

}

- (void) imagePager:(KIImagePager *)imagePager didSelectImageAtIndex:(NSUInteger)index
{
    NSLog(@"%s %d", __PRETTY_FUNCTION__, index);
}

@end
