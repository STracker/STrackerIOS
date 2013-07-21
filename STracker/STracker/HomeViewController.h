//
//  CalendarViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 24/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+KNSemiModal.h"
#import "KIImagePager.h"
#import "AppDelegate.h"

/*!
 @discussion This view controller is the first controller appears in applicaton.
 */
@interface HomeViewController : UIViewController <KIImagePagerDelegate, KIImagePagerDataSource, UIActionSheetDelegate, UIAlertViewDelegate>
{
    __weak IBOutlet KIImagePager *_imagePager;
    
    AppDelegate *_app;
    NSMutableArray *_top;
    UIAlertView *_alertTv;
    UIAlertView *_alertUser;
}

/*!
 @discussion The action method that is invoked when user click 
 in search icon.
 */
- (IBAction)searchOptions:(UIBarButtonItem *)sender;

/*!
 @discussion The action method that is invoked when user click 
 in user options icon.
 */
- (IBAction)userOptions:(id)sender;

@end