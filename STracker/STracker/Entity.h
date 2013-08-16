//
//  Entity.h
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>

// Only for EntityDelegate knows the EntitySynopsis type...
@class EntitySynopsis;

/*!
 @discussion Protocol for deserialize objects.
 */
@protocol Deserialize

/*!
 @discussion Init method that constructs the object with values passed
 in parameters.
 @param parameters The dictionary of parameters.
 @return An instance of the object deserialized.
 */
- (id)initWithDictionary:(NSDictionary *)parameters;

@end

/*!
 @discussion Protocol for entities.
 */
@protocol EntityDelegate

/*!
 @discussion Method for generate the entity synopsis.
 @return An instance of the entity synopsis.
 */
- (EntitySynopsis *)getSynopsis;

@end

/*!
 @discussion This object defines the base entity object for all models.
 */
@interface Entity : NSObject <Deserialize>

// All entities have an version number for caching.
@property(nonatomic) int version;

@end

/*!
 @discussion This object defines the base synopsis object for all synopses models.
 */
@interface EntitySynopsis : NSObject <Deserialize>

@property(nonatomic, copy) NSString *name;

// Every synopsis contains one uri for your model.
@property(nonatomic, copy) NSString *uri;

@end