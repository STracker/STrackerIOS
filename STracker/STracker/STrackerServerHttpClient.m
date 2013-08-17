//
//  STrackerServerHttpClient.m
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "STrackerServerHttpClient.h"

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
    
    // For debug...
    NSLog(@"disc capacity %d", cache.diskCapacity);
    NSLog(@"disc usage %d", cache.currentDiskUsage);
    NSLog(@"memory capacity %d", cache.memoryCapacity);
    NSLog(@"memory usage %d", cache.currentMemoryUsage);
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return (error != nil) ? nil : [NSString stringWithFormat:@"%d", [[json objectForKey:@"Version"] intValue]];
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