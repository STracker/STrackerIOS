//
//  User.h
//  STracker
//
//  Created by Ricardo Sousa on 06/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Person.h"

/*!
 @discussion This object defines the user entity object.
 */
@interface User : Entity

@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *photoUrl;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, strong) NSArray *friends;
@property(nonatomic, strong) NSMutableArray *subscriptions;
@property(nonatomic, strong) NSArray *suggestions;
@property(nonatomic, strong) NSArray *friendRequests;

@end

/*!
 @discussion This object defines the user synopsis entity object.
 */
@interface UserSynopsis : EntitySynopsis

@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, copy) NSString *photoUrl;

// Necessary for save the photo in table views.
@property(nonatomic, strong) UIImage *photo;


@end