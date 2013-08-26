//
//  UserCalendar.h
//  STracker
//
//  Created by Ricardo Sousa on 22/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

@class EpisodeSynopsis;

/*!
 @discussion Class that defines the user episodes calendar.
 */
@interface UserCalendar : NSObject <Deserialize>

@property(nonatomic, strong) NSArray *entries;

@end

@interface UserCalendarEntry : NSObject <Deserialize>

@property(nonatomic, copy) NSString *date;
@property(nonatomic, strong) NSMutableArray *episodes;

@end

@interface EpisodeCalendar : NSObject

@property(nonatomic, copy) NSString *tvshowName;
@property(nonatomic, strong) EpisodeSynopsis *episode;

@end



