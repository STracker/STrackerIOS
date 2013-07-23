//
//  InfoController.h
//  STracker
//
//  Created by Ricardo Sousa on 23/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

/*!
 @discussion Base class for controllers that manage 
 information.
 */
@interface InfoController : NSObject
{
    AppDelegate *_app;
}

/*!
 @discussion Class method that returns a shared singleton instance.
 @return an singleton instance.
 */
+ (id)sharedObject;

@end
