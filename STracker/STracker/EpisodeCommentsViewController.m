//
//  EpisodeCommentsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/10/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "EpisodeCommentsViewController.h"

@interface EpisodeCommentsViewController ()

@end

@implementation EpisodeCommentsViewController

- (id)initWithEpisode:(Episode *)episode
{
    if (self = [super initWithData:[[NSMutableArray alloc] init]])
        _episode = episode;
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[STrackerServerHttpClient sharedClient] getEpisodeComments:_episode success:^(AFJSONRequestOperation *operation, id result) {
        
        _data = nil;
        _data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            Comment *comment = [[Comment alloc] initWithDictionary:item];
            [_data addObject:comment];
        }
        
        [self.tableView reloadData];
                
    } failure:nil];
}

#pragma mark - Hook methods.
- (void)popupTextViewHook:(YIPopupTextView*)textView didDismissWithText:(NSString*)text cancelled:(BOOL)cancelled
{
    [[STrackerServerHttpClient sharedClient] postEpisodeComment:_episode comment:text success:^(AFJSONRequestOperation *operation, id result) {
        
        // Nothing to do...
        
    } failure:nil];
}

@end
