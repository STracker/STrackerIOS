//
//  STrackerServerHttpClient.m
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "STrackerServerHttpClient.h"

@implementation AFHTTPClient (IgnoreCacheData)

- (void)getPathWithoutLocalCache:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    NSMutableURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:parameters];
    
    // Extra code.
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    //
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self enqueueHTTPRequestOperation:operation];
}

@end

@implementation STrackerServerHttpClient

/*!
 @discussion Override the init method, for set some properties 
 of this AFHTTPClient instance.
 */
- (id)init
{
    NSString *baseURL = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerServerBaseURL"];
    
    if (self = [super initWithBaseURL:[NSURL URLWithString:baseURL]])
    {
        _app = [[UIApplication sharedApplication] delegate];
        
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        
    }
    
    return self;
}

#pragma mark - STrackerServerHttpClient public methods.
+ (id)sharedClient
{
    static STrackerServerHttpClient *sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[STrackerServerHttpClient alloc] init];
    });
    
    return sharedClient;
}

- (void)getRequest:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self getPath:uri parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (success != nil)
            success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (failure != nil)
            failure((AFJSONRequestOperation *)operation, error);
    }];
}

- (void)getRequestWithHawkProtocol:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure
{   
    // Generate and set the Authorization header with Hawk protocol.
    NSString *url = [NSString stringWithFormat:@"%@%@", self.baseURL, uri];
    
    if (query != nil)
        url = [url stringByAppendingString:[NSString stringWithFormat:@"?%@", [self transformDictionaryToQueryString:query]]];
    
    NSString *header = [HawkClient generateAuthorizationHeader:[NSURL URLWithString:url] method:@"GET" timestamp:[HawkClient getTimestamp] nonce:[HawkClient generateNonce] credentials:_app.hawkCredentials ext:nil payload:nil payloadValidation:NO];
    
    [self setDefaultHeader:@"Authorization" value:header];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self getPath:uri parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean Authorization header.
        [self setDefaultHeader:@"Authorization" value:nil];
        
        if (success != nil)
            success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean Authorization header.
        [self setDefaultHeader:@"Authorization" value:nil];
        
        if (failure != nil)
            failure((AFJSONRequestOperation *)operation, error);
    }];
}

- (void)postRequest:(NSString *)uri parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self postPath:uri parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (success != nil)
            success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (failure != nil)
            failure((AFJSONRequestOperation *)operation, error);
    }];
}

- (void)postRequestWithHawkProtocol:(NSString *)uri parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{    
    // Generate and set the Authorization header with Hawk protocol.
    NSString *url = [NSString stringWithFormat:@"%@%@", self.baseURL, uri];
    NSString *header = [HawkClient generateAuthorizationHeader:[NSURL URLWithString:url] method:@"POST" timestamp:[HawkClient getTimestamp] nonce:[HawkClient generateNonce] credentials:_app.hawkCredentials ext:nil payload:[self trasnformPayloadToUrlEncoded:parameters] payloadValidation:YES];
    
    [self setDefaultHeader:@"Authorization" value:header];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self postPath:uri parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean Authorization header.
        [self setDefaultHeader:@"Authorization" value:nil];
        
        if (success != nil)
            success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean Authorization header.
        [self setDefaultHeader:@"Authorization" value:nil];
        
        if (failure != nil)
            failure((AFJSONRequestOperation *)operation, error);
    }];
}

- (void)deleteRequest:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self deletePath:uri parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (success != nil)
            success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (failure != nil)
            failure((AFJSONRequestOperation *)operation, error);
    }];
}

- (void)deleteRequestWithHawkProtocol:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure
{
    // Generate and set the Authorization header with Hawk protocol.
    NSString *url = [NSString stringWithFormat:@"%@%@", self.baseURL, uri];
    NSString *header = [HawkClient generateAuthorizationHeader:[NSURL URLWithString:url] method:@"DELETE" timestamp:[HawkClient getTimestamp] nonce:[HawkClient generateNonce] credentials:_app.hawkCredentials ext:nil payload:nil payloadValidation:NO];
    
    [self setDefaultHeader:@"Authorization" value:header];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self deletePath:uri parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean Authorization header.
        [self setDefaultHeader:@"Authorization" value:nil];
        
        if (success != nil)
            success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean Authorization header.
        [self setDefaultHeader:@"Authorization" value:nil];
        
        if (failure != nil)
            failure((AFJSONRequestOperation *)operation, error);
    }];
}

#pragma mark - Caching methods.

- (void)getRequest:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure withCacheControl:(NSString *)versionNumber
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // Set If-None-Match HTTP request header.
    [self setDefaultHeader:@"If-None-Match" value:versionNumber];
    
    [self getPathWithoutLocalCache:uri parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean If-None-Match header.
        [self setDefaultHeader:@"If-None-Match" value:nil];
        
        if (success != nil)
            success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean If-None-Match header.
        [self setDefaultHeader:@"If-None-Match" value:nil];
        
        if (failure != nil)
            failure((AFJSONRequestOperation *)operation, error);
    }];
}

- (void)getRequestWithoutCacheLocalData:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure withCacheControl:(NSString *)versionNumber
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // Set If-None-Match HTTP request header.
    [self setDefaultHeader:@"If-None-Match" value:versionNumber];
    
    [self getPathWithoutLocalCache:uri parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean If-None-Match header.
        [self setDefaultHeader:@"If-None-Match" value:nil];
        
        if (success != nil)
            success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean If-None-Match header.
        [self setDefaultHeader:@"If-None-Match" value:nil];
        
        if (operation.response.statusCode == 304)
        {
            NSString *etag = [operation.response.allHeaderFields objectForKey:@"ETag"];
            if ([etag isEqualToString:[NSString stringWithFormat:@"\"%@\"", versionNumber]])
            {
                success((AFJSONRequestOperation *)operation, nil);
                return;
            }
        }
        
        if (failure != nil)
            failure((AFJSONRequestOperation *)operation, error);
    }];
}

- (void)getRequestWithHawkProtocol:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure withCacheControl:(NSString *)versionNumber
{
    // Generate and set the Authorization header with Hawk protocol.
    NSString *url = [NSString stringWithFormat:@"%@%@", self.baseURL, uri];
    if (query != nil)
        url = [url stringByAppendingString:[NSString stringWithFormat:@"?%@", [self transformDictionaryToQueryString:query]]];
    
    NSString *header = [HawkClient generateAuthorizationHeader:[NSURL URLWithString:url] method:@"GET" timestamp:[HawkClient getTimestamp] nonce:[HawkClient generateNonce] credentials:_app.hawkCredentials ext:nil payload:nil payloadValidation:NO];
    
    [self setDefaultHeader:@"Authorization" value:header];
    
    // Set If-None-Match HTTP request header.
    [self setDefaultHeader:@"If-None-Match" value:versionNumber];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self getPath:uri parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean Authorization header.
        [self setDefaultHeader:@"Authorization" value:nil];
        
        // Clean If-None-Match header.
        [self setDefaultHeader:@"If-None-Match" value:nil];
        
        if (success != nil)
            success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean Authorization header.
        [self setDefaultHeader:@"Authorization" value:nil];
        
        // Clean If-None-Match header.
        [self setDefaultHeader:@"If-None-Match" value:nil];
        
        if (failure != nil)
            failure((AFJSONRequestOperation *)operation, error);
    }];
}

- (void)getRequestWithHawkProtocolWithoutCacheLocalData:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure withCacheControl:(NSString *)versionNumber
{
    // Generate and set the Authorization header with Hawk protocol.
    NSString *url = [NSString stringWithFormat:@"%@%@", self.baseURL, uri];
    if (query != nil)
        url = [url stringByAppendingString:[NSString stringWithFormat:@"?%@", [self transformDictionaryToQueryString:query]]];
    
    NSString *header = [HawkClient generateAuthorizationHeader:[NSURL URLWithString:url] method:@"GET" timestamp:[HawkClient getTimestamp] nonce:[HawkClient generateNonce] credentials:_app.hawkCredentials ext:nil payload:nil payloadValidation:NO];
    
    [self setDefaultHeader:@"Authorization" value:header];
    
    // Set If-None-Match HTTP request header.
    [self setDefaultHeader:@"If-None-Match" value:versionNumber];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self getPathWithoutLocalCache:uri parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean Authorization header.
        [self setDefaultHeader:@"Authorization" value:nil];
        
        // Clean If-None-Match header.
        [self setDefaultHeader:@"If-None-Match" value:nil];
        
        if (success != nil)
            success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean Authorization header.
        [self setDefaultHeader:@"Authorization" value:nil];
        
        // Clean If-None-Match header.
        [self setDefaultHeader:@"If-None-Match" value:nil];
        
        if (operation.response.statusCode == 304)
        {
            NSString *etag = [operation.response.allHeaderFields objectForKey:@"ETag"];
            if ([etag isEqualToString:[NSString stringWithFormat:@"\"%@\"", versionNumber]])
            {
                success((AFJSONRequestOperation *)operation, nil);
                return;
            }
        }
        
        if (failure != nil)
            failure((AFJSONRequestOperation *)operation, error);
    }];

}

#pragma mark - STrackerServerHttpClient private auxiliary methods.

- (NSString *)trasnformPayloadToUrlEncoded:(NSDictionary *)parameters
{
    NSMutableString *payload = [NSMutableString string];
    for (int i = [parameters allKeys].count - 1; i >= 0; i--)
    {
        if ([payload length] > 0)
            [payload appendString:@"&"];
        
        NSString *param = [parameters objectForKey:[[parameters allKeys] objectAtIndex:i]];
        NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)param, NULL, (CFStringRef)@"!*'();:@&=$,/?%#[]", kCFStringEncodingUTF8 ));
        
        [payload appendFormat:@"%@=%@", [[parameters allKeys] objectAtIndex:i], encodedString];
    }
    
    return payload;
}

- (NSString *)transformDictionaryToQueryString:(NSDictionary *)parameters
{
    NSMutableString *query = [NSMutableString string];
    for (int i = [parameters allKeys].count - 1; i >= 0; i--)
    {
        if ([query length] > 0)
            [query appendString:@"&"];
        
        NSString *param = [parameters objectForKey:[[parameters allKeys] objectAtIndex:i]];
        param = [param stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        
        [query appendFormat:@"%@=%@", [[parameters allKeys] objectAtIndex:i], param];
    }
    
    return query;
}

@end