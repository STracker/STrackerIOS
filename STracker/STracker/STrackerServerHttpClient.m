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

- (void)getRequest:(NSString *)url query:(NSDictionary *)query success:(Success)success failure:(Failure)failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self getPath:url parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (success != nil)
            success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (failure != nil)
            failure((AFJSONRequestOperation *)operation, error);
    }];
}

- (void)getRequestWithHawkProtocol:(NSString *)url query:(NSDictionary *)query success:(Success)success failure:(Failure)failure
{
    HawkCredentials *credentials = [_app getHawkCredentials];
    if (credentials == nil)
        return;
    
    // Generate and set the Authorization header with Hawk protocol.
    NSString *header = [HawkClient generateAuthorizationHeader:[NSURL URLWithString:url] method:@"GET" timestamp:[HawkClient getTimestamp] nonce:[HawkClient generateNonce] credentials:credentials ext:nil payload:nil payloadValidation:NO];
    
    [self setDefaultHeader:@"Authorization" value:header];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self getPath:url parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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

- (void)postRequest:(NSString *)url parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self postPath:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (success != nil)
            success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (failure != nil)
            failure((AFJSONRequestOperation *)operation, error);
    }];
}

- (void)postRequestWithHawkProtocol:(NSString *)url parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    HawkCredentials *credentials = [_app getHawkCredentials];
    if (credentials == nil)
        return;
    
    // Generate and set the Authorization header with Hawk protocol.
    NSString *header = [HawkClient generateAuthorizationHeader:[NSURL URLWithString:url] method:@"POST" timestamp:[HawkClient getTimestamp] nonce:[HawkClient generateNonce] credentials:credentials ext:nil payload:[self trasnformPayloadToUrlEncoded:parameters] payloadValidation:YES];
    
    [self setDefaultHeader:@"Authorization" value:header];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self postPath:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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

- (void)deleteRequest:(NSString *)url query:(NSDictionary *)query success:(Success)success failure:(Failure)failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self deletePath:url parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (success != nil)
            success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (failure != nil)
            failure((AFJSONRequestOperation *)operation, error);
    }];
}

- (void)deleteRequestWithHawkProtocol:(NSString *)url query:(NSDictionary *)query success:(Success)success failure:(Failure)failure
{
    HawkCredentials *credentials = [_app getHawkCredentials];
    if (credentials == nil)
        return;
    
    // Generate and set the Authorization header with Hawk protocol.
    NSString *header = [HawkClient generateAuthorizationHeader:[NSURL URLWithString:url] method:@"DELETE" timestamp:[HawkClient getTimestamp] nonce:[HawkClient generateNonce] credentials:credentials ext:nil payload:nil payloadValidation:NO];
    
    [self setDefaultHeader:@"Authorization" value:header];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self deletePath:url parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

@end