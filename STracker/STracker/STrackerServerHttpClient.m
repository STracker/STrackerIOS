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
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    
    return self;
}

#pragma mark - Genres operations.
- (void)getGenres:(Success)success failure:(Failure)failure
{
    [self getPath:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerServerBaseGenresURI"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success((AFJSONRequestOperation *)operation, responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure((AFJSONRequestOperation *)operation, error);
     }];
}

- (void)getTvShowsByGenre:(GenreSynopsis *)genre success:(Success)success failure:(Failure) failure
{
    NSDictionary *query = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:genre.name] forKeys:[NSArray arrayWithObject:@"genre"]];
    
    [self getPath:genre.uri parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success((AFJSONRequestOperation *)operation, responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure((AFJSONRequestOperation *)operation, error);
     }];
}

#pragma mark - Tv shows operations.
- (void)getTvshow:(TvShowSynopse *)tvshow success:(Success)success failure:(Failure) failure
{
    [self getPath:tvshow.uri parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success((AFJSONRequestOperation *)operation, responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure((AFJSONRequestOperation *)operation, error);
     }];
}

- (void)getTvshowsByName:(NSString *)name success:(Success)success failure:(Failure) failure
{
    NSDictionary *query = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:name] forKeys:[NSArray arrayWithObject:@"name"]];
    
    [self getPath:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerServerBaseTvShowsURI"] parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success((AFJSONRequestOperation *)operation, responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure((AFJSONRequestOperation *)operation, error);
     }];
}

- (void)getTopRated:(Success)success failure:(Failure) failure
{
    
    [self getPath:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerServerBaseTopRatedURI"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success((AFJSONRequestOperation *)operation, responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure((AFJSONRequestOperation *)operation, error);
     }];
}

#pragma mark - Seasons operations.
- (void)getSeason:(SeasonSynopsis *)season success:(Success)success failure:(Failure) failure
{
    [self getPath:season.uri parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success((AFJSONRequestOperation *)operation, responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure((AFJSONRequestOperation *)operation, error);
     }];
}

#pragma mark - Seasons operations.
- (void)getEpisode:(EpisodeSynopsis *)episode success:(Success)success failure:(Failure) failure
{
    [self getPath:episode.uri parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        success((AFJSONRequestOperation *)operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failure((AFJSONRequestOperation *)operation, error);
    }];
}

@end