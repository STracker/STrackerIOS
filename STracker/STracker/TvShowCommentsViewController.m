/*
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
    if (self = [super initWithData:[[NSMutableArray alloc] init]])
        _tvshow = tvshow;
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[STrackerServerHttpClient sharedClient] getTvshowComments:_tvshow success:^(AFJSONRequestOperation *operation, id result) {
        
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
    [[STrackerServerHttpClient sharedClient] postTvShowComment:_tvshow comment:text success:^(AFJSONRequestOperation *operation, id result) {
    
        //Nothing to do...
    } failure:nil];
}

@end
*/