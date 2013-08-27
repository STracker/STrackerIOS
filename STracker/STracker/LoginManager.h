//
//  LoginManager.h
//  STracker
//
//  Created by Ricardo Sousa on 25/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

/*!
 @discussion Login manager class.
 */
@interface LoginManager : NSObject

/*!
 @discussion Performs the login with FB account.
 @param finish  Callback that was called when login was
 complete.
 */
+ (void)login:(Finish) finish;

@end