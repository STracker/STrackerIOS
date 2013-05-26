//
//  InfoManager.m
//  STracker
//
//  Created by Ricardo Sousa on 5/26/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "InfoDownloadManager.h"

@implementation InfoDownloadManager

+ (void)performDownloadWithRequest:(NSURLRequest *)request andCallback:(Callback)callback
{
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        callback(data, httpResponse.statusCode, error);
    }];
}

+ (NSURL *)contructUrlWithPath:(NSString *)path andQuery:(NSString *)query
{
    NSString *baseURL = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerServerBaseURL"];
    
    NSString *url;

    if (query == nil)
        url = [NSString stringWithFormat:@"%@%@", baseURL, path];
    else
        url = [NSString stringWithFormat:@"%@%@?%@", baseURL, path, query];
    
    return [NSURL URLWithString: url];
}

@end