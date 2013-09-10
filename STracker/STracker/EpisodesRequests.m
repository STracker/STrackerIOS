//
//  EpisodesController.m
//  STracker
//
//  Created by Ricardo Sousa on 23/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "EpisodesRequests.h"
#import "STrackerServerHttpClient.h"
#import "Episode.h"

@implementation EpisodesRequests

+ (void)getEpisode:(NSString *)uri finish:(Finish) finish
{
    NSString *version = [[STrackerServerHttpClient sharedClient] tryGetVersionFromtCachedData:uri];
    
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        Episode *episode = [[Episode alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(episode);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
        
    } withVersion:version];
}

@end