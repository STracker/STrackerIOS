//
//  DownloadFiles.h
//  STracker
//
//  Created by Ricardo Sousa on 6/17/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>

// Definition of callback for finish downloading image.
typedef void (^FinishDownloadImage)(UIImage *image);

@interface DownloadFiles : NSObject
{
    dispatch_queue_t downloadImagesQueue;
}

/*!
 @discussion Class method that returns a shared singleton instance.
 @return an singleton instance.
 */
+ (id)sharedObject;

/*!
 @discussion This method allows download an image asynchronously.
 @param url     The url of the image.
 @param finish  The callback that is called when the image is completely downloaded.
 */
- (void)downloadImageFromUrl:(NSURL *) url finish:(FinishDownloadImage) finish;

@end
