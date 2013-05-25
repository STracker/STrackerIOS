//
//  InformationManager.h
//  STracker
//
//  Created by Ricardo Sousa on 5/25/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TvShow.h"

#define GETBYGENRE_URL @"http://strackerserverdev.apphb.com/api/tvshows?genre="

@interface InformationManager : NSObject

- (NSArray *)getShowsWithGenre: (NSString *)genre;

@end
