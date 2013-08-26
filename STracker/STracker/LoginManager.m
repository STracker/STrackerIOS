//
//  LoginManager.m
//  STracker
//
//  Created by Ricardo Sousa on 25/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "LoginManager.h"
#import "FacebookView.h"
#import "UIViewController+KNSemiModal.h"

@implementation LoginManager

+ (void)loginWithFacebook:(Finish) finish
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    FacebookView *fb = [[FacebookView alloc] initWithCallback:^(id obj) {
        
        [app.window.rootViewController dismissSemiModalView];
        finish(obj);
    }];

    [app.window.rootViewController presentSemiView:fb];
}

+ (void)logoutFromFacebook:(Finish)finish
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    FacebookView *fb = [[FacebookView alloc] initWithCallback:^(id obj) {
        
        [app.window.rootViewController dismissSemiModalView];
        finish(obj);
    }];
    
    [app.window.rootViewController presentSemiView:fb];

}

@end