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

- (void)getSeason:(NSString *)uri finish:(Finish)finish
{
    [[STrackerServerHttpClient sharedClient] getRequest:uri query:nil success:^(AFJSONRequestOperation *operation, id result) {
        
        Season *season = [[Season alloc] initWithDictionary:result];
        
        // Invoke callback.
        finish(season);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

#pragma mark - InfoController abstract methods.

+ (id)sharedObject
{
    static SeasonsController *sharedObject = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[SeasonsController alloc] init];
    });
    
    return sharedObject;
}

@end
