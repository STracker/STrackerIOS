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

+ (UIAlertView *)getAlertForError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error occured" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    return alert;
}

- (id)init
{
    NSString *baseURL = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerServerBaseURL"];
    
    if (self = [super initWithBaseURL:[NSURL URLWithString:baseURL]])
    {
        hawkClient = [[HawkClient_iOS alloc] init];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    
    return self;
}

#pragma mark - Genres operations.
- (void)getGenres:(Success)success failure:(Failure)failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self getPath:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerServerBaseGenresURI"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         success((AFJSONRequestOperation *)operation, responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         failure((AFJSONRequestOperation *)operation, error);
     }];
}

#pragma mark - Tv shows operations.
- (void)getTvshow:(TvShowSynopse *)tvshow success:(Success)success failure:(Failure) failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self getPath:tvshow.uri parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         success((AFJSONRequestOperation *)operation, responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         failure((AFJSONRequestOperation *)operation, error);
     }];
}

- (void)getTvshowsByName:(NSString *)name success:(Success)success failure:(Failure) failure
{
    NSDictionary *query = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:name] forKeys:[NSArray arrayWithObject:@"name"]];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self getPath:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerServerBaseTvShowsURI"] parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         success((AFJSONRequestOperation *)operation, responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         failure((AFJSONRequestOperation *)operation, error);
     }];
}

- (void)getTvShowsByGenre:(GenreSynopsis *)genre success:(Success)success failure:(Failure) failure
{
    NSDictionary *query = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:genre.name] forKeys:[NSArray arrayWithObject:@"genre"]];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self getPath:genre.uri parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         success((AFJSONRequestOperation *)operation, responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         failure((AFJSONRequestOperation *)operation, error);
     }];
}

- (void)getTopRated:(Success)success failure:(Failure) failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self getPath:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerServerBaseTopRatedURI"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         success((AFJSONRequestOperation *)operation, responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         failure((AFJSONRequestOperation *)operation, error);
     }];
}

#pragma mark - Seasons operations.
- (void)getSeason:(SeasonSynopsis *)season success:(Success)success failure:(Failure) failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self getPath:season.uri parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         success((AFJSONRequestOperation *)operation, responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         failure((AFJSONRequestOperation *)operation, error);
     }];
}

#pragma mark - Episodes operations.
- (void)getEpisode:(EpisodeSynopsis *)episode success:(Success)success failure:(Failure) failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self getPath:episode.uri parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure((AFJSONRequestOperation *)operation, error);
    }];
}

#pragma mark - Users operations.

- (NSString *)getTimestamp
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setDateFormat:TIME_FORMAT];
    [dateFormatter setTimeZone:timeZone];
    NSDate * date = [dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]];
    NSTimeInterval interval = [date timeIntervalSince1970];
    long timestamp = interval / 1000L;
    return [NSString stringWithFormat:@"%ld", timestamp];
}

- (NSString *)getAuthorizeHeader:(NSString *)uri parameters:(NSDictionary *)parameters payload:(NSString *)payload method:(NSString *)method
{
    NSString *timestamp = [self getTimestamp];
    NSURL *url;
    if (parameters == nil) 
    url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", self.baseURL, uri]];
    else
        // TODO
        url = nil;
    
    HawkCredentials *credentials = [[HawkCredentials alloc] init];
    credentials.key = @"werxhqb98rpaxn39848xrunpaw3489ruxnpa98w4rxn";
    credentials.identifier = @"100005516760836";
    
    NSString *header = [hawkClient generateAuthorizationHeader:url method:method timestamp:timestamp nonce:@"LawkW" credentials:credentials payload:payload ext:nil];
    
    return header;
}

- (void)getUserInfo:(Success)success failure:(Failure) failure
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserInfoURI"];
    NSString *header = [self getAuthorizeHeader:uri parameters:nil payload:nil method:@"GET"];
    NSLog(@"%@", header);
    [self setDefaultHeader:@"Authorization" value:header];
    
    [self getPath:uri parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"%@", error.localizedDescription);
        NSLog(@"%@", error.localizedFailureReason);
        failure((AFJSONRequestOperation *)operation, error);
    }];
}

@end