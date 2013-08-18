//
//  SuggestionData.h
//  STracker
//
//  Created by Ricardo Sousa on 8/17/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SuggestionData : NSManagedObject

@property (nonatomic, retain) NSManagedObject *user;
@property (nonatomic, retain) NSManagedObject *tvshow;
@property (nonatomic, retain) NSManagedObject *heldBy;

@end
