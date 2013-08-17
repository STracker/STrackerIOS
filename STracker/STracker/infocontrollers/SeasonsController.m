//
//  SeasonsController.m
//  STracker
//
//  Created by Ricardo Sousa on 23/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "SeasonsController.h"
#import "STrackerServerHttpClient.h"
#import "Season.h"

@implementation SeasonsController

+ (void)getSeason:(NSString *)uri finish:(Finish) finish
{
    NSString *version = [[STrackerServerHttpClient sharedClient] tryGeVersionFromtCachedData:uri];
    
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        Season *season = [[Season alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(season);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[AppDelegate getAlertViewForErrors:error.localizedDescription] show];
        
    } withVersion:version];
}

@end