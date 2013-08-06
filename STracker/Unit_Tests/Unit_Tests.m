//
//  Unit_Tests.m
//  Unit_Tests
//
//  Created by Ricardo Sousa on 8/6/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Unit_Tests.h"
#import "UsersController.h"
#import "TvShowsController.h"

@implementation Unit_Tests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testTvShowGet
{
    NSString *uri = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"STrackerTopRatedTvShowsURI"];
    [[TvShowsController sharedObject] getTvShow:uri finish:^(id obj) {
        
        TvShow *tvshow = obj;
        
        STAssertEquals(tvshow.name, @"Breaking Bad", @"");
        STAssertEquals(tvshow.tvshowId, @"tt0903747", @"");
    }]
}

@end
