//
//  SuggestViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 18/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SuggestViewController.h"
#import "UsersController.h"

@implementation SuggestViewController

- (id)initWithData:(NSArray *)data andTvShowId:(NSString *)tvshowId
{
    if (self = [super initWithData:data])
        _tvshowId = tvshowId;
    
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
