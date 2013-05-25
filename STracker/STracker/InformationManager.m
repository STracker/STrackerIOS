//
//  InformationManager.m
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "InformationManager.h"

@implementation InformationManager

- (NSArray *)getShowsWithGenre:(NSString *)genre
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", GETBYGENRE_URL, genre]];    
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (data == nil)
        return nil;
    
    NSError *error;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (error)
        return nil;
    
    NSMutableArray *tvshows = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in result) {
        TvShow *tvshow = [[TvShow alloc] init];
        tvshow.imdbid = [item objectForKey:@"Id"];
        tvshow.name = [item objectForKey:@"Name"];
        
        [tvshows addObject:tvshow];
    }
    
    return tvshows;
}


@end
