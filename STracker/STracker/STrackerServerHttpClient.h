//
//  STrackerServerHttpClient.h
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

// Define the callbacks.
typedef void (^Success)(AFJSONRequestOperation *operation, id result);
typedef void (^Failure)(AFJSONRequestOperation *operation, NSError *error);

@interface STrackerServerHttpClient : AFHTTPClient

// Class method that returns a shared singleton instance.
+ (id)sharedClient;

// Tv shows operations.
- (void)getByGenre:(NSString *)genre success:(Success)success failure:(Failure) failure;
- (void)getByImdbId:(NSString *)imdbId success:(Success)success failure:(Failure) failure;

@end
