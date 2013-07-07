//
//  ProfileViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 07/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIImagePager.h"
#import "TvShow.h"

#define BACKGROUND @"BackgroundPattern.png"

@interface SlideshowViewController : UIViewController <KIImagePagerDelegate, KIImagePagerDataSource>
{
    __weak IBOutlet KIImagePager *imagePager;
    __weak IBOutlet UILabel *title;
}

@property(nonatomic, strong) NSArray *items;

@end
