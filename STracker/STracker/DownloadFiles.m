//
//  DownloadFiles.m
//  STracker
//
//  Created by Ricardo Sousa on 6/17/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "DownloadFiles.h"

@implementation DownloadFiles

+ (id)sharedObject
{
    static DownloadFiles *sharedObject = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[DownloadFiles alloc] init];
    });
    
    return sharedObject;
}

- (id)init
{
    if (self = [super init]) 
      downloadImagesQueue = dispatch_queue_create("images", nil);
    
    return self;
}

- (void)downloadImageFromUrl:(NSURL *) url finish:(Finish) finish
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    dispatch_async(downloadImagesQueue, ^{
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            finish(img);
        });
    });
}

@end
