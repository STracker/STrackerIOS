//
//  TvShowsController.m
//  STracker
//
//  Created by Ricardo Sousa on 23/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowsController.h"
#import "STrackerServerHttpClient.h"

@implementation TvShowsController

+ (void)getTvShow:(NSString *)uri finish:(Finish) finish
{
    NSString *version = [[STrackerServerHttpClient sharedClient] tryGeVersionFromtCachedData:uri];
    
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        TvShow *tvshow = [[TvShow alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(tvshow);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
        
    } withVersion:version];
}

+ (void)getTvShowsByName:(NSString *)name withRange:(Range *)range finish:(Finish)finish
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerTvShowsURI"];
    
    NSArray *keys = [[NSArray alloc] initWithObjects:@"name", @"start", @"end", nil];
    NSArray *values = [[NSArray alloc] initWithObjects:name, [NSString stringWithFormat:@"%d", range.start], [NSString stringWithFormat:@"%d", range.end], nil];
    NSDictionary *query = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:query success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish([self parseTvShowsToArray:result]);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
        
    } withVersion:nil];
}

+ (void)getTvShowsTopRated:(Finish) finish
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerTopRatedTvShowsURI"];
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
              
        // Invoke callback.
        finish([self parseTvShowsToArray:result]);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
        
    } withVersion:nil];

}

#pragma mark - TvShowsController private auxiliary methods.

+ (NSArray *)parseTvShowsToArray:(id) result
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (NSDictionary *item in result)
    {
        TvShowSynopsis *synopse = [[TvShowSynopsis alloc] initWithDictionary:item];
        [data addObject:synopse];
    }
    
    return data;
}

@end
