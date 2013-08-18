//
//  OfflineUserInfoController.m
//  STracker
//
//  Created by Ricardo Sousa on 8/18/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "OfflineUserInfoController.h"
#import "UserData.h"
#import "UserSynopsisData.h"
#import "Subscription.h"
#import "SubscriptionData.h"
#import "TvShow.h"
#import "TvShowSynopsisData.h"
#import "Episode.h"
#import "EpisodeSynopsisData.h"
#import "Suggestion.h"
#import "SuggestionData.h"

@implementation OfflineUserInfoController

- (id)initWithContext:(NSManagedObjectContext *)context
{
    if (self = [super init])
        _context = context;
    
    return self;
}

- (void)create:(User *)user
{
    // Verify if allready exists in DB.
    if ([self read] != nil)
        return;
    
    [self parseUser:user];
    
    NSError *error;
    [_context save:&error];
    if (error)
        NSLog(@"error: %@", error.description);
}

- (User *)read
{
    
    return nil;
}

- (void)update:(User *)user
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserData" inManagedObjectContext:_context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [_context executeFetchRequest:fetchRequest error:&error];
    if (error)
    {
        NSLog(@"error: %@", error.description);
        return;
    }
    
    UserData *uData = [fetchedObjects objectAtIndex:0]; // Only have one...
    
    // Update information.
    uData = [self parseUser:user];
    
    // Perform action.
    [_context save:&error];
    if (error)
        NSLog(@"error: %@", error.description);
}

- (void)remove
{
    [NSException raise:@"Not implemented." format:@"Not implemented."];
}

#pragma mark - OfflineUserInfoController auxiliary private methods.

/*!
 @discussion Auxiliary method for parse one tvshow synopsis to TvShowSynopsisData.
 @return The object parsed.
 */
- (TvShowSynopsisData *)parseTvShowSynopsis:(TvShowSynopsis *)tvshow
{
    TvShowSynopsisData *tvData = [NSEntityDescription insertNewObjectForEntityForName:@"TvShowSynopsisData" inManagedObjectContext:_context];
    tvData.identifier = tvshow.identifier;
    tvData.name = tvshow.name;
    tvData.uri = tvshow.uri;
    tvData.poster = tvshow.poster;
    
    return tvData;
}

/*!
 @discussion Auxiliary method for parse one episde synopsis to EpisodeSynopsisData.
 @return The object parsed.
 */
- (EpisodeSynopsisData *)parseEpisdeSynopsis:(EpisodeSynopsis *)episode
{
    EpisodeSynopsisData *eData = [NSEntityDescription insertNewObjectForEntityForName:@"EpisodeSynopsisData" inManagedObjectContext:_context];
    eData.tvshowId = episode.identifier.tvshowId;
    eData.seasonNumber = [[NSNumber alloc] initWithInt:episode.identifier.seasonNumber];
    eData.episodeNumber = [[NSNumber alloc] initWithInt:episode.identifier.episodeNumber];
    eData.name = episode.name;
    eData.uri = episode.uri;
    eData.date = episode.date;
    
    return eData;
}

/*!
 @discussion Auxiliary method for parse one user synopsis to UserSynopsisData.
 @return The object parsed.
 */
- (UserSynopsisData *)parseUserSynopsis:(UserSynopsis *)user
{
    UserSynopsisData *uData = [NSEntityDescription insertNewObjectForEntityForName:@"UserSynopsisData" inManagedObjectContext:_context];
    uData.name = user.name;
    uData.identifier = user.identifier;
    uData.uri = user.uri;
    uData.photoUrl = user.photoUrl;
    
    return uData;
}

/*!
 @discussion Auxiliary method for parse one user to UserData.
 @return The object parsed.
 */
- (UserData *)parseUser:(User *)user
{
    UserData *newData = [NSEntityDescription insertNewObjectForEntityForName:@"UserData" inManagedObjectContext:_context];
    newData.identifier = user.identifier;
    newData.name = user.name;
    newData.email = user.email;
    newData.photoUrl = user.photoUrl;
    newData.version = [[NSNumber alloc] initWithInt:user.version];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    // Create friends.
    for (UserSynopsis *synopsis in user.friends.allValues)
    {
        [array addObject:[self parseUserSynopsis:synopsis]];
    }
    
    newData.friends = [[NSSet alloc] initWithArray:array];
    
    // Friend requests.
    array = nil;
    array = [[NSMutableArray alloc] init];
    for (UserSynopsis *synopsis in user.friendRequests.allValues)
    {
        [array addObject:[self parseUserSynopsis:synopsis]];
    }
    
    newData.friendRequests = [[NSSet alloc] initWithArray:array];
    
    // Subscriptions.
    array = nil;
    array = [[NSMutableArray alloc] init];
    for (Subscription *subscription in user.subscriptions.allValues)
    {
        SubscriptionData *sData = [NSEntityDescription insertNewObjectForEntityForName:@"SubscriptionData" inManagedObjectContext:_context];
        
        sData.tvshow = [self parseTvShowSynopsis:subscription.tvshow];
        
        NSMutableArray *arrayEpis = [[NSMutableArray alloc] init];
        for (EpisodeSynopsis *episode in subscription.episodesWatched)
        {
            [arrayEpis addObject:[self parseEpisdeSynopsis:episode]];
        }
        
        sData.episodesWatched = [[NSSet alloc] initWithArray:arrayEpis];
        
        [array addObject:sData];
    }
    
    newData.subscriptions = [[NSSet alloc] initWithArray:array];
    
    // Suggestions.
    array = nil;
    array = [[NSMutableArray alloc] init];
    for (Suggestion *suggestion in user.suggestions.allValues)
    {
        SuggestionData *sData = [NSEntityDescription insertNewObjectForEntityForName:@"SuggestionData" inManagedObjectContext:_context];
        
        sData.user = [self parseUserSynopsis:suggestion.user];
        sData.tvshow = [self parseTvShowSynopsis:suggestion.tvshow];
        
        [array addObject:sData];
    }
    
    newData.suggestions = [[NSSet alloc] initWithArray:array];
    
    return newData;
}


@end
