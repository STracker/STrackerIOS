//
//  Episode.h
//  STracker
//
//  Created by Ricardo Sousa on 6/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"
#import "Person.h"
#import "Actor.h"

@interface EpisodeSynopsis : Entity

@property(nonatomic, copy) NSString *number;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *uri;

@end

@interface Episode : Entity

@property(nonatomic, copy) NSString *number;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *description;
@property(nonatomic, copy) NSString *date;
@property(nonatomic, copy) NSString *poster;
@property(nonatomic, retain) NSMutableArray *directors;
@property(nonatomic, retain) NSMutableArray *guestActors;

@end
