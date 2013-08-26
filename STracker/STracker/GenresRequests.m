//
//  GenresController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/24/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "GenresRequests.h"
#import "STrackerServerHttpClient.h"
#import "Genre.h"

@implementation GenresRequests

+ (void)getGenres:(Finish) finish
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerGenresURI"];
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            GenreSynopsis *synopsis = [[GenreSynopsis alloc] initWithDictionary:item];
            [data addObject:synopsis];
        }
        
        // Invoke callback.
        finish(data);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
        
    } withVersion:nil];
}

+ (void)getGenre:(NSString *) uri finish:(Finish) finish
{
    NSString *version = [[STrackerServerHttpClient sharedClient] tryGeVersionFromtCachedData:uri];
    
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        Genre *genre = [[Genre alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(genre);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
        
    } withVersion:version];
}

@end
