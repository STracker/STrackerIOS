//
//  DownloadFiles.h
//  STracker
//
//  Created by Ricardo Sousa on 6/17/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Finish)(UIImage *image);

@interface DownloadFiles : NSObject

+ (void)downloadImageFromUrl:(NSURL *) url finish:(Finish) finish;

@end
