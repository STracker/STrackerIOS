//
//  STrackerServerHttpClient.m
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "STrackerServerHttpClient.h"

@implementation STrackerServerHttpClient

- (id)init
{
    NSString *baseURL = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerServerBaseURL"];
    
    if (self = [super initWithBaseURL:[NSURL URLWithString:baseURL]])
    {
        _hawkClient = [[HawkClient_iOS alloc] init];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    
    return self;
}

+ (id)sharedClient
{
    static STrackerServerHttpClient *sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[STrackerServerHttpClient alloc] init];
    });
    
    return sharedClient;
}

- (void)setHawkCredentials:(HawkCredentials *)credentials
{
    _credentials = credentials;
}

- (UIAlertView *)getAlertForError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error occured" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    return alert;
}

// Auxiliary method for get the timestamp.
- (NSString *)getTimestamp
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setDateFormat:TIME_FORMAT];
    [dateFormatter setTimeZone:timeZone];
    NSDate * date = [dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]];
    NSTimeInterval interval = [date timeIntervalSince1970];
    long timestamp = interval;
    return [NSString stringWithFormat:@"%ld", timestamp];
}

// Auxiliary method for set the authorization header with Hawk protocol.
- (void)setAuthorizationHeader:(NSURL *)url method:(NSString *)method
{
    NSString *timestamp = [self getTimestamp];
    
    // Generate random nonce.
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *nonce = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    CFRelease(uuid);
    
    NSString *header = [_hawkClient generateAuthorizationHeader:url method:method timestamp:timestamp nonce:nonce credentials:_credentials payload:nil ext:nil];
    
    [self setDefaultHeader:@"Authorization" value:header];
}

#pragma mark - Users operations.
- (void)postUser:(User *)user success:(Success)success failure:(Failure)failure
{
    NSString *path = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerUserInfoURI"];
    
    [self setAuthorizationHeader:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", self.baseURL, path]] method:@"POST"];
    
    NSArray *objs = [NSArray arrayWithObjects:user.identifier, user.name, user.email, user.photoURL, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"Id", @"Name", @"Email", @"Photo", nil];
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjects:objs forKeys:keys];
    
    [self postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self getAlertForError:error];
        failure((AFJSONRequestOperation *)operation, error);
    }];
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
         [self getAlertForError:error];
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
         [self getAlertForError:error];
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
         [self getAlertForError:error];
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
         [self getAlertForError:error];
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
         [self getAlertForError:error];
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
         [self getAlertForError:error];
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
        [self getAlertForError:error];
        failure((AFJSONRequestOperation *)operation, error);
    }];
}

#pragma mark - Ratings operations.
- (void)getTvShowRating:(TvShow *)tvshow success:(Success)success failure:(Failure) failure;
{
    NSString *path = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerRatingsURL"];
    path = [path stringByReplacingOccurrencesOfString:@"id" withString:tvshow.imdbId];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self getAlertForError:error];
        failure((AFJSONRequestOperation *)operation, error);
    }];
}

- (void)postTvShowRating:(TvShow *)tvshow rating:(float)rating success:(Success)success failure:(Failure) failure
{
    NSString *path = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerRatingsURL"];
    path = [path stringByReplacingOccurrencesOfString:@"id" withString:tvshow.imdbId];
    
    NSString * ratingStr = [NSString stringWithFormat:@"%f", rating];
    NSDictionary *params = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:tvshow.imdbId, ratingStr, nil] forKeys:[NSArray arrayWithObjects:@"id", @"rating", nil]];
    
    [self setAuthorizationHeader:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.baseURL, path]] method:@"POST"];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self getAlertForError:error];
        
        NSLog(@"%@", error.description);
        failure((AFJSONRequestOperation *)operation, error);
    }];
}
- (void)getEpisodeRating:(Episode *)episode success:(Success)success failure:(Failure) failure
{
    // TODO
}
- (void)postEpisodeRating:(Episode *)episode rating:(float)rating success:(Success)success failure:(Failure) failure
{
    // TODO
}

@end