//
//  UserData.h
//  STracker
//
//  Created by Ricardo Sousa on 8/17/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/*!
 @discussion Object generated automatically from Core Data model.
 */
@interface UserData : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * photoUrl;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * version;

/*
 For the next objects, I don't use the relationships in Core Data (one-to-many), 
 because never occurs any query for this objects. So is use the dynamic typification 
 of the objective-c. Because this entities are "transformables", is necessary to 
 implement the encode/decode methods.
 */
@property (nonatomic, retain) id subscriptions;
@property (nonatomic, retain) id friends;
@property (nonatomic, retain) id friendRequests;
@property (nonatomic, retain) id suggestions;

@end