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

#define TIME_FORMAT @"yyyy-MM-dd HH:mm:ss"

@class HawkCredentials;

// Definition of callbacks (Success and Failure).
typedef void (^Success)(AFJSONRequestOperation *operation, id result);
typedef void (^Failure)(AFJSONRequestOperation *operation, NSError *error);

/*!
 @discussion This object defines the HTTP operations performed to STracker server.
 Is inherited from AFHTTPClient to use the advantages of the AFNetworking framework.
 @see http://afnetworking.com/
 */
@interface STrackerServerHttpClient : AFHTTPClient

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
- (NSString *)tryGetVersionFromtCachedData:(NSString *)uri;

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
 @param uri         The uri.
 @param query       The query, is optional.
 @param success     The callback for success request.
 @param failure     The callback for failure request.
 @param version     Entity version number, for cache control (not required).
 @param credentials The hawk credentials (required).
 */
- (void)getRequestWithHawkProtocol:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure withVersion:(NSString *) version andHawkCredentials:(HawkCredentials *)credentials;

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
 @param credentials The hawk credentials (required).
 */
- (void)postRequestWithHawkProtocol:(NSString *)uri parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure andHawkCredentials:(HawkCredentials *)credentials;

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
 @param uri         The uri.
 @param query       The query, is optional.
 @param success     The callback for success request.
 @param failure     The callback for failure request.
 @param credentials The hawk credentials (required).
 */
- (void)deleteRequestWithHawkProtocol:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure andHawkCredentials:(HawkCredentials *)credentials;;

@end