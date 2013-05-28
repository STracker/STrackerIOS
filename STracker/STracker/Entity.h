//
//  Entity.h
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entity : NSObject

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (id)verifyValue: (id)value defaultValue:(id)defaultValue;

@end