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
#import "AppDelegate.h"
#import "HawkClient.h"

#define TIME_FORMAT @"yyyy-MM-dd HH:mm:ss"

// Definition of callbacks (Success and Failure).
typedef void (^Success)(AFJSONRequestOperation *operation, id result);
typedef void (^Failure)(AFJSONRequestOperation *operation, NSError *error);

/*!
 @discussion This object defines the HTTP operations performed to STracker server.
 Is inherited from AFHTTPClient to use the advantages of the AFNetworking framework.
 @see http://afnetworking.com/
 */
@interface STrackerServerHttpClient : AFHTTPClient
{
    AppDelegate *_app;
}

/*!
 @discussion Class method that returns a shared singleton instance.
 @return an singleton instance.
 */
+ (id)sharedClient;

/*!
 @discussion Method for making an HTTP GET request to STracker server.
 @param url     The url.
 @param query   The query, is optional.
 @param success The callback for success request.
 @param failure The callback for failure request.
 */
- (void)getRequest:(NSString *)url query:(NSDictionary *)query success:(Success)success failure:(Failure)failure;

/*!
 @discussion Method for making an HTTP GET request to STracker server with the Hawk protocol protection.
 @param url     The url.
 @param query   The query, is optional.
 @param success The callback for success request.
 @param failure The callback for failure request.
 */
- (void)getRequestWithHawkProtocol:(NSString *)url query:(NSDictionary *)query success:(Success)success failure:(Failure)failure;

/*!
 @discussion Method for making an HTTP POST request to STracker server.
 @param url         The url.
 @param parameters  The parameters, body of the request.
 @param success     The callback for success request.
 @param failure     The callback for failure request.
 */
- (void)postRequest:(NSString *)url parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;

/*!
 @discussion Method for making an HTTP POST request to STracker server with the Hawk protocol protection. This method use 
 the payload validation option of Hawk protocol.
 @param url         The url.
 @param parameters  The parameters, body of the request.
 @param success     The callback for success request.
 @param failure     The callback for failure request.
 */
- (void)postRequestWithHawkProtocol:(NSString *)url parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;

/*!
 @discussion Method for making an HTTP DELETE request to STracker server.
 @param url     The url.
 @param query   The query, is optional.
 @param success The callback for success request.
 @param failure The callback for failure request.
 */
- (void)deleteRequest:(NSString *)url query:(NSDictionary *)query success:(Success)success failure:(Failure)failure;

/*!
 @discussion Method for making an HTTP DELETE request to STracker server with the Hawk protocol protection.
 @param url     The url.
 @param query   The query, is optional.
 @param success The callback for success request.
 @param failure The callback for failure request.
 */
- (void)deleteRequestWithHawkProtocol:(NSString *)url query:(NSDictionary *)query success:(Success)success failure:(Failure)failure;

@end
