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

- (void)getGenres:(NSString *)uri finish:(Finish)finish
{
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            GenreSynopse *synopse = [[GenreSynopse alloc] initWithDictionary:item];
            [data addObject:synopse];
        }
        
        // Invoke callback.
        finish(data);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

- (void)getGenre:(NSString *) uri finish:(Finish) finish
{
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        Genre *genre = [[Genre alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(genre);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

#pragma mark - InfoController abstract methods.

+ (id)sharedObject
{
    static GenresController *sharedObject = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[GenresController alloc] init];
    });
    
    return sharedObject;
}

@end
