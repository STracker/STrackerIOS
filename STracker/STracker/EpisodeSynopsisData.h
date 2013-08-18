//
//  EpisodeSynopsisData.h
//  STracker
//
//  Created by Ricardo Sousa on 8/17/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EpisodeSynopsisData : NSManagedObject

@property (nonatomic, retain) NSString * tvshowId;
@property (nonatomic, retain) NSNumber * seasonNumber;
@property (nonatomic, retain) NSNumber * episodeNumber;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * uri;
@property (nonatomic, retain) NSString * date;

@end