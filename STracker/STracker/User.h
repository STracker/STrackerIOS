//
//  User.h
//  STracker
//
//  Created by Ricardo Sousa on 06/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Person.h"

@class HawkCredentials;

/*!
 @discussion This object defines the user entity object.
 */
@interface User : Entity <Deserialize, EntityDelegate>
{
    /*
     Needed for perform secure requests to server.
     Only used for current user.
     */
    @private HawkCredentials *_hawkCredentials;
}

@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *photoUrl;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, strong) NSMutableArray *suggestions;

// This next properties are mutable dictionaries for fast search, insert and delete.
@property(nonatomic, strong) NSMutableDictionary *friends;
@property(nonatomic, strong) NSMutableDictionary *subscriptions;
@property(nonatomic, strong) NSMutableDictionary *friendRequests;

/*!
 @discussion Gets the user's hawk credentials.
 Only used by current user.
 @return The _hawkCredentials.
 */
- (HawkCredentials *)getHawkCredentials;

@end

/*!
 @discussion This object defines the user synopsis entity object.
 */
@interface UserSynopsis : EntitySynopsis <Deserialize>

@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, copy) NSString *photoUrl;

// Necessary for save the photo in table views.
@property(nonatomic, strong) UIImage *photo;

@end