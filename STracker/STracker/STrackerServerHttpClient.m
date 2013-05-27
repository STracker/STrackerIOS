//
//  STrackerServerHttpClient.m
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "STrackerServerHttpClient.h"

@implementation STrackerServerHttpClient

+ (id)sharedClient
{
    static STrackerServerHttpClient *sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[STrackerServerHttpClient alloc] init];
    });
    
    return sharedClient;
}

- (id)init
{
    NSString *baseURL = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerServerBaseURL"];
    
    if (self = [super initWithBaseURL:[NSURL URLWithString:baseURL]])
    {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    
    return self;
}

#pragma mark - Tv shows operations.
- (void)getByGenre:(NSString *)genre success:(Success)success failure:(Failure) failure
{
    NSDictionary *query = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:genre] forKeys:[NSArray arrayWithObject:@"genre"]];
    
    [self getPath:@"api/tvshows" parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failure((AFJSONRequestOperation *)operation, error);
    }];
}

- (void)getByImdbId:(NSString *)imdbId success:(Success)success failure:(Failure)failure
{
    NSString *path = [NSString stringWithFormat:@"api/tvshows/%@", imdbId];
    
    [self getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success((AFJSONRequestOperation *)operation, responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure((AFJSONRequestOperation *)operation, error);
     }];
}

@end