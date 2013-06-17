//
//  DownloadFiles.m
//  STracker
//
//  Created by Ricardo Sousa on 6/17/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "DownloadFiles.h"

@implementation DownloadFiles

+ (void)downloadImageFromUrl:(NSURL *) url finish:(Finish) finish
{
    dispatch_queue_t downloadQueue = dispatch_queue_create("getImage", nil);
    dispatch_async(downloadQueue, ^{
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            finish(img);
        });
    });
}

@end
