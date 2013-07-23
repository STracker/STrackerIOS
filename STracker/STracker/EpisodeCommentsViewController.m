//
//  EpisodeCommentsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/10/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "EpisodeCommentsViewController.h"
#import "STrackerServerHttpClient.h"

@implementation EpisodeCommentsViewController

- (id)initWithData:(NSArray *)data andEpisode:(Episode *)episode
{
    if (self = [super initWithData: data])
        _episode = episode;
    
    return self;
}

#pragma mark - Hook methods.
- (void)popupTextViewHook:(NSString*)text
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerEpisodeCommentsURI"];
    uri = [uri stringByReplacingOccurrencesOfString:@"tvshowId" withString:_episode.tvshowId];
    uri = [uri stringByReplacingOccurrencesOfString:@"seasonNumber" withString:[NSString stringWithFormat:@"%@", _episode.seasonNumber]];
    uri = [uri stringByReplacingOccurrencesOfString:@"episodeNumber" withString:[NSString stringWithFormat:@"%@", _episode.episodeNumber]];
    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:text, @"", nil];
    
    [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
        
        // Nothing to do...
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

@end
