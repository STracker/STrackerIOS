//
//  InfoManager.h
//  STracker
//
//  Created by Ricardo Sousa on 5/26/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Callback)(NSData *, int, NSError *);

@interface InfoDownloadManager : NSObject

+ (void)performDownloadWithRequest:(NSURLRequest *)request andCallback:(Callback)callback;

+ (NSURL *)contructUrlWithPath:(NSString *)path andQuery:(NSString *)query;

@end