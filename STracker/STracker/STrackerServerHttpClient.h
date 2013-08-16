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
 @discussion AFNetworking use the NSURLCache object to store in the disc the 
 cached data, is a nice feature, but in the case of STracker is not... Because
 the STracker have 3 application clients, so if the user change one entity and 
 this entity it was previous stored in local cache in iOS application, when user 
 opens the 
 
 
 
 . But in the case of STracker, there is the probability
 of the user making changes into the Web, and so are never reflected in iOS
 application because the data in cache is old.
 The STracker server, returns the status code 304 when the version number of 
 the entity is equal to the version sended in If-None-Match HTTP request header.
 This category adds one new method to AFHTTPClient for making HTTP GET requests 
 ignoring the local cache data. 
 */
@interface AFHTTPClient (IgnoreCacheData)

// Almost the same definition to the getPath in AFHTTPClient.
- (void)getPathWithoutLocalCache:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end

/*!
 @discussion This object defines the HTTP operations performed to STracker server.
 Is inherited from AFHTTPClient to use the advantages of the AFNetworking framework.
 @see http://afnetworking.com/
 */
@interface STrackerServerHttpClient : AFHTTPClient
{
    @private
    AppDelegate *_app;
}

/*!
 @discussion Class method that returns a shared singleton instance.
 @return an singleton instance.
 */
+ (id)sharedClient;

/*!
 @discussion Method for making an HTTP GET request to STracker server.
 @param uri     The uri.
 @param query   The query, is optional.
 @param success The callback for success request.
 @param failure The callback for failure request.
 */
- (void)getRequest:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure;

/*!
 @discussion Method for making an HTTP GET request to STracker server with the Hawk protocol
 protection.
 @param uri     The uri.
 @param query   The query, is optional.
 @param success The callback for success request.
 @param failure The callback for failure request.
 */
- (void)getRequestWithHawkProtocol:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure;

/*!
 @discussion Method for making an HTTP POST request to STracker server.
 @param uri         The uri.
 @param parameters  The parameters, body of the request.
 @param success     The callback for success request.
 @param failure     The callback for failure request.
 */
- (void)postRequest:(NSString *)uri parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;

/*!
 @discussion Method for making an HTTP POST request to STracker server with the Hawk protocol protection. This method use 
 the payload validation option of Hawk protocol.
 @param uri         The uri.
 @param parameters  The parameters, body of the request.
 @param success     The callback for success request.
 @param failure     The callback for failure request.
 */
- (void)postRequestWithHawkProtocol:(NSString *)uri parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;

/*!
 @discussion Method for making an HTTP DELETE request to STracker server.
 @param uri     The uri.
 @param query   The query, is optional.
 @param success The callback for success request.
 @param failure The callback for failure request.
 */
- (void)deleteRequest:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure;

/*!
 @discussion Method for making an HTTP DELETE request to STracker server with the Hawk protocol protection.
 @param uri     The uri.
 @param query   The query, is optional.
 @param success The callback for success request.
 @param failure The callback for failure request.
 */
- (void)deleteRequestWithHawkProtocol:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure;

/*!
 @discussion Method for making an HTTP GET request to STracker server.
 @param uri             The uri.
 @param query           The query, is optional.
 @param success         The callback for success request.
 @param failure         The callback for failure request.
 @param versionNumber   The version number for set the If-None-Match HTTP header.
 */
- (void)getRequest:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure withCacheControl:(NSString *) versionNumber;

/*!
 @discussion Method for making an HTTP GET request to STracker server.
 @param uri             The uri.
 @param query           The query, is optional.
 @param success         The callback for success request.
 @param failure         The callback for failure request.
 @param versionNumber   The version number for set the If-None-Match HTTP header.
 */
- (void)getRequestWithHawkProtocol:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure withCacheControl:(NSString *) versionNumber;
@end