//
//  GenresController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/24/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "GenresController.h"
#import "STrackerServerHttpClient.h"
#import "Genre.h"

@implementation GenresController

+ (void)getGenres:(NSString *)uri finish:(Finish)finish
{
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            GenreSynopsis *synopse = [[GenreSynopsis alloc] initWithDictionary:item];
            [data addObject:synopse];
        }
        
        // Invoke callback.
        finish(data);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

+ (void)getGenre:(NSString *) uri finish:(Finish) finish
{
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        Genre *genre = [[Genre alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(genre);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

@end
