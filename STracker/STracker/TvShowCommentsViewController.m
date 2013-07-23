//
//  TvShowCommentsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 09/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "TvShowCommentsViewController.h"

@implementation TvShowCommentsViewController

- (id)initWithTvShow:(TvShow *)tvshow
{
    if (self = [super initWithData:[[NSArray alloc] init]])
    {
        _tvshow = tvshow;
        
        // Set uri for this television show comments.
        _commentsUri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerTvShowCommentsURI"];
        _commentsUri = [_commentsUri stringByReplacingOccurrencesOfString:@"id" withString:_tvshow.tvshowId];
    }    
    
    return self;
}

@end