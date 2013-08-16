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

- (NSString *)tryGeVersionFromtCachedData:(NSString *)uri
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:uri parameters:nil];
    NSURLCache *cache = [NSURLCache sharedURLCache];
    NSCachedURLResponse *cacheresponse = [cache cachedResponseForRequest:request];
    NSData *data = cacheresponse.data;
    if (data == nil)
        return nil;
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return (error == nil) ? nil : [json objectForKey:@"Version"];
}

- (void)getRequest:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure withVersion:(NSString *) version
{
    if (version != nil)
        [self setDefaultHeader:@"If-None-Match" value:version];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self getPath:uri parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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

- (void)getRequestWithHawkProtocol:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure withVersion:(NSString *) version
{   
    // Generate and set the Authorization header with Hawk protocol.
    NSString *url = [NSString stringWithFormat:@"%@%@", self.baseURL, uri];
    if (query != nil)
        url = [url stringByAppendingString:[NSString stringWithFormat:@"?%@", [self transformDictionaryToQueryString:query]]];
    
    NSString *header = [HawkClient generateAuthorizationHeader:[NSURL URLWithString:url] method:@"GET" timestamp:[HawkClient getTimestamp] nonce:[HawkClient generateNonce] credentials:_app.hawkCredentials ext:nil payload:nil payloadValidation:NO];
    
    [self setDefaultHeader:@"Authorization" value:header];
    
    if (version != nil)
        [self setDefaultHeader:@"If-None-Match" value:version];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self getPath:uri parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean Authorization headers.
        [self setDefaultHeader:@"Authorization" value:nil];
        [self setDefaultHeader:@"If-None-Match" value:nil];
        
        if (success != nil)
            success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean Authorization headers.
        [self setDefaultHeader:@"Authorization" value:nil];
        [self setDefaultHeader:@"If-None-Match" value:nil];
        
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

#pragma mark - Without local cache methods.

- (void)getRequestWithoutCacheLocalData:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure withVersion:(NSString *)version
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // Set If-None-Match HTTP request header.
    [self setDefaultHeader:@"If-None-Match" value:version];
    
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
        
        if ([self checkIfResponseIsNotModified:operation version:version])
        {
            success((AFJSONRequestOperation *)operation, nil);
            return;
        }
        
        if (failure != nil)
            failure((AFJSONRequestOperation *)operation, error);
    }];
}

- (void)getRequestWithHawkProtocoAndlWithoutCacheLocalData:(NSString *)uri query:(NSDictionary *)query success:(Success)success failure:(Failure)failure withVersion:(NSString *)version
{
    // Generate and set the Authorization header with Hawk protocol.
    NSString *url = [NSString stringWithFormat:@"%@%@", self.baseURL, uri];
    if (query != nil)
        url = [url stringByAppendingString:[NSString stringWithFormat:@"?%@", [self transformDictionaryToQueryString:query]]];
    
    NSString *header = [HawkClient generateAuthorizationHeader:[NSURL URLWithString:url] method:@"GET" timestamp:[HawkClient getTimestamp] nonce:[HawkClient generateNonce] credentials:_app.hawkCredentials ext:nil payload:nil payloadValidation:NO];
    
    [self setDefaultHeader:@"Authorization" value:header];
    
    // Set If-None-Match HTTP request header.
    [self setDefaultHeader:@"If-None-Match" value:version];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self getPathWithoutLocalCache:uri parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean headers.
        [self setDefaultHeader:@"Authorization" value:nil];
        [self setDefaultHeader:@"If-None-Match" value:nil];
        
        if (success != nil)
            success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Clean headers.
        [self setDefaultHeader:@"Authorization" value:nil];
        [self setDefaultHeader:@"If-None-Match" value:nil];
        
        if ([self checkIfResponseIsNotModified:operation version:version])
        {
            success((AFJSONRequestOperation *)operation, nil);
            return;
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

/*!
 @discussion Auxiliary method for check if status code is 304 (Not modified). Also checks if the ETag value is equal to 
 value in version, if is equal, the entity did not change.
 */
- (BOOL)checkIfResponseIsNotModified:(AFHTTPRequestOperation *)operation version:(NSString *) version
{
    if (operation.response.statusCode == 304)
    {
        NSString *etag = [operation.response.allHeaderFields objectForKey:@"ETag"];
        if ([etag isEqualToString:[NSString stringWithFormat:@"\"%@\"", version]])
        {
            return YES;
        }
    }
    
    return NO;
}

@end