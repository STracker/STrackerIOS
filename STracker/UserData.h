//
//  UserData.h
//  STracker
//
//  Created by Ricardo Sousa on 8/17/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SubscriptionData, SuggestionData;

@interface UserData : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * photoUrl;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * version;
@property (nonatomic, retain) NSSet *subscriptions;
@property (nonatomic, retain) NSSet *suggestions;
@property (nonatomic, retain) NSSet *friends;
@property (nonatomic, retain) NSSet *friendRequests;
@end

@interface UserData (CoreDataGeneratedAccessors)

- (void)addSubscriptionsObject:(SubscriptionData *)value;
- (void)removeSubscriptionsObject:(SubscriptionData *)value;
- (void)addSubscriptions:(NSSet *)values;
- (void)removeSubscriptions:(NSSet *)values;

- (void)addSuggestionsObject:(SuggestionData *)value;
- (void)removeSuggestionsObject:(SuggestionData *)value;
- (void)addSuggestions:(NSSet *)values;
- (void)removeSuggestions:(NSSet *)values;

- (void)addFriendsObject:(NSManagedObject *)value;
- (void)removeFriendsObject:(NSManagedObject *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;

- (void)addFriendRequestsObject:(NSManagedObject *)value;
- (void)removeFriendRequestsObject:(NSManagedObject *)value;
- (void)addFriendRequests:(NSSet *)values;
- (void)removeFriendRequests:(NSSet *)values;

@end
