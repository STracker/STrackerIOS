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
 cached data, is a nice feature, but in the case of STracker, have some 
 problems namely in POST - GET users because it is possible to change user's
 data in other application. So if already have in cache previous user information 
 from one GET request, and user change the information in the Web, 
 and then make the login in iOS application, will be make one POST 
 request to STracker server that will be response with the user's 
 information updated. If after that, the user make a GET request for 
 user's information, the server will be response with an 304 and the 
 AFNetworking will return the data that have in cache from previous GET operation. 
 The problem is that the data is not updated. This is a particular case, and 
 happens only with user's information entity.
 This category adds one new method to AFHTTPClient for making HTTP GET requests 
 ignoring the local cache data. So its needed to check the status code and ETag 
 header value in the server response.
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
 @discussion Because the entities synopsis don't have the version of the 
 entity, this method try to get the version of the entity in NSURLCache 
 shared cache. The usage of this method is for get the version, for use it 
 in the header If-None-Match.
 @param uri The entity uri for search in the cache.
 @return The version if the entity exists in cache, or nil if not.
 */
- (NSString *)tryGeVersionFromtCachedData:(NSString *)uri;

/*!
 @discussion Method for making an HTTP GET request to STracker server.
 @param uri     The uri.
 @param query   The query, is optional.
 @param success The callback for success request.
 @param failure The callback for failure request.
 @param version Entity version number, for cache control (not required).
 */
- (void)getRequest:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure withVersion:(NSString *) version;

/*!
 @discussion Method for making an HTTP GET request to STracker server with the Hawk protocol
 protection.
 @param uri     The uri.
 @param query   The query, is optional.
 @param success The callback for success request.
 @param failure The callback for failure request.
 @param version Entity version number, for cache control (not required).
 */
- (void)getRequestWithHawkProtocol:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure withVersion:(NSString *) version;

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
 @discussion Method for making an HTTP GET request to STracker server.  Not use
 the local cache data.
 @param uri     The uri.
 @param query   The query, is optional.
 @param success The callback for success request.
 @param failure The callback for failure request.
 @param version The version number for set the If-None-Match HTTP header.
 */
- (void)getRequestWithoutCacheLocalData:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure withVersion:(NSString *) version;

/*!
 @discussion Method for making an HTTP GET request to STracker server. Not use 
 the local cache data.
 @param uri     The uri.
 @param query   The query, is optional.
 @param success The callback for success request.
 @param failure The callback for failure request.
 @param version The version number for set the If-None-Match HTTP header.
 */
- (void)getRequestWithHawkProtocoAndlWithoutCacheLocalData:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure withVersion:(NSString *) version;

@end