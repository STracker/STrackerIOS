//
//  EpisodesController.m
//  STracker
//
//  Created by Ricardo Sousa on 23/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "EpisodesController.h"
#import "STrackerServerHttpClient.h"
#import "Episode.h"

@implementation EpisodesController

+ (void)getEpisode:(NSString *)uri finish:(Finish)finish
{
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        Episode *episode = [[Episode alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(episode);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [[app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

@end
