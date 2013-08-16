//
//  Season.h
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"

/*!
 @discussion This object defines the identifier of the seasons.
 */
@interface SeasonId : NSObject <Deserialize>

@property(nonatomic, copy) NSString *tvshowId;
@property(nonatomic) int seasonNumber;

/*!
 @discussion Init method that constructs the object with values passed
 in parameters.
 @param parameters The dictionary of parameters.
 @return An instance of SeasonId.
 */
- (id)initWithDictionary:(NSDictionary *)parameters;

@end

/*!
 @discussion This object defines the season entity object.
 */
@interface Season : Entity <Deserialize>

@property(nonatomic, strong) SeasonId *identifier;
@property(nonatomic, retain) NSArray *episodes;

@end

/*!
 @discussion This object defines the season synopsis entity object.
 */
@interface SeasonSynopsis : EntitySynopsis <Deserialize>

@property(nonatomic, strong) SeasonId *identifier;

@end
