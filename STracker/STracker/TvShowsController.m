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
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        TvShow *tvshow = [[TvShow alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(tvshow);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)getTvShowsByName:(NSString *)name uri:(NSString *)uri finish:(Finish)finish
{
    NSDictionary *query = [[NSDictionary alloc] initWithObjectsAndKeys:name, @"name", nil];
    
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:query success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish([self parseTvShowsToArray:result]);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)getTvShowsTopRated:(NSString *)uri finish:(Finish) finish
{
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
              
        // Invoke callback.
        finish([self parseTvShowsToArray:result]);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];

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
