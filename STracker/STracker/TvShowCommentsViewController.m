//
//  TvShowCommentsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 09/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowCommentsViewController.h"
#import "STrackerServerHttpClient.h"
#import "Comment.h"

@implementation TvShowCommentsViewController

- (id)initWithData:(NSArray *)data andTvShow:(TvShow *)tvshow
{
    if (self = [super initWithData:data])
        _tvshow = tvshow;
    
    return self;
}

#pragma mark - CommentsViewController abstract methods.

- (void)popupTextViewHook:(NSString*)text
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerTvShowCommentsURI"];
    uri = [uri stringByReplacingOccurrencesOfString:@"id" withString:_tvshow.tvshowId];
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:text, @"", nil];
    
    [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
        
        // Nothing to do...
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

@end