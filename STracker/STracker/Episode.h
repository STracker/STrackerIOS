//
//  Episode.h
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"

/*!
 @discussion This object defines the identifier of the episodes.
 */
@interface EpisodeId : NSObject <Deserialize>

@property(nonatomic, copy) NSString *tvshowId;
@property(nonatomic) int seasonNumber;
@property(nonatomic) int episodeNumber;

/*!
 @discussion Init method that constructs the object with values passed
 in parameters.
 @param parameters The dictionary of parameters.
 @return An instance of EpisodeId.
 */
- (id)initWithDictionary:(NSDictionary *)parameters;

@end

/*!
 @discussion This object defines the episode entity object.
 */
@interface Episode : Entity <Deserialize>

@property(nonatomic, strong) EpisodeId *identifier;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *description;
@property(nonatomic, copy) NSString *date;
@property(nonatomic, copy) NSString *poster;
@property(nonatomic, retain) NSArray *directors;
@property(nonatomic, retain) NSArray *guestActors;

@end

/*!
 @discussion This object defines the episode synopsis entity object.
 */
@interface EpisodeSynopsis : EntitySynopsis <Deserialize>

@property(nonatomic, strong) EpisodeId *identifier;
@property(nonatomic, copy) NSString *date;

@end