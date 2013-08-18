//
//  SubscriptionData.h
//  STracker
//
//  Created by Ricardo Sousa on 8/17/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EpisodeSynopsisData;

@interface SubscriptionData : NSManagedObject

@property (nonatomic, retain) NSManagedObject *tvshow;
@property (nonatomic, retain) NSSet *episodesWatched;
@property (nonatomic, retain) NSManagedObject *heldBy;
@end

@interface SubscriptionData (CoreDataGeneratedAccessors)

- (void)addEpisodesWatchedObject:(EpisodeSynopsisData *)value;
- (void)removeEpisodesWatchedObject:(EpisodeSynopsisData *)value;
- (void)addEpisodesWatched:(NSSet *)values;
- (void)removeEpisodesWatched:(NSSet *)values;

@end
