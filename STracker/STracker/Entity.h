//
//  Entity.h
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @discussion This object defines the base entity object for all models.
 */
@interface Entity : NSObject

/*!
 @discussion Init method that constructs the object with values passed 
 in parameters.
 @param parameters The dictionary of parameters.
 @return An instance of Entity.
 */
- (id)initWithDictionary:(NSDictionary *)parameters;

@end

/*!
 @discussion This object defines the base synopsis object for all synopses models.
 */
@interface EntitySynopsis : NSObject

@property(nonatomic, copy) NSString *name;

// Every synopsis contains one uri for your model.
@property(nonatomic, copy) NSString *uri;

/*!
 @discussion Init method that constructs the object with values passed
 in parameters.
 @param parameters The dictionary of parameters.
 @return An instance of EntitySynopsis.
 */
- (id)initWithDictionary:(NSDictionary *)parameters;

@end