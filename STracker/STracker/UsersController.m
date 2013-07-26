//
//  UsersController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/26/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "UsersController.h"
#import "STrackerServerHttpClient.h"

@implementation UsersController

-(void)registUser:(NSString *)uri withUser:(User *)user finish:(Finish)finish
{
    NSArray *keys = [[NSArray alloc] initWithObjects:@"Name", @"Email", @"Photo", nil];
    NSArray *values = [[NSArray alloc] initWithObjects:user.name, user.email, user.photoUrl, nil];
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    
    [[STrackerServerHttpClient sharedClient] postRequestWithHawkProtocol:uri parameters:parameters success:^(AFJSONRequestOperation *operation, id result) {
        
        // Invoke callback.
        finish(nil);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

- (void)searchUser:(NSString *)uri withName:(NSString *)name finish:(Finish)finish
{
    NSDictionary *query = [[NSDictionary alloc] initWithObjectsAndKeys:name, @"name", nil];
    
    [[STrackerServerHttpClient sharedClient] getRequestWithHawkProtocol:uri query:query success:^(AFJSONRequestOperation *operation, id result) {
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *item in result)
        {
            UserSinopse *synopse = [[UserSinopse alloc] initWithDictionary:item];
            [data addObject:synopse];
        }
        
        //Invoke callback.
        finish(data);
        
    } failure:^(AFJSONRequestOperation *operation, NSError *error) {
        
        [[_app getAlertViewForErrors:error.localizedDescription] show];
    }];
}

#pragma mark - InfoController abstract methods.

+ (id)sharedObject
{
    static UsersController *sharedObject = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[UsersController alloc] init];
    });
    
    return sharedObject;
}

@end
