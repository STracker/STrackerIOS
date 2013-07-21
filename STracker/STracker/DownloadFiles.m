//
//  DownloadFiles.m
//  STracker
//
//  Created by Ricardo Sousa on 6/17/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "DownloadFiles.h"

@implementation DownloadFiles

/*!
 @discussion Override the init method, for set some properties.
 */
- (id)init
{
    if (self = [super init])
        // Create the queue for images.
        downloadImagesQueue = dispatch_queue_create("images", nil);
    
    return self;
}

#pragma mark - DownloadFiles public methods.

+ (id)sharedObject
{
    static DownloadFiles *sharedObject = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[DownloadFiles alloc] init];
    });
    
    return sharedObject;
}

- (void)downloadImageFromUrl:(NSURL *) url finish:(FinishDownloadImage) finish
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    dispatch_async(downloadImagesQueue, ^{
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        // Run the next code into main thread.
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            finish(img);
        });
    });
}

@end
