//
//  Comment.h
//  STracker
//
//  Created by Ricardo Sousa on 7/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Entity.h"
#import "User.h"
#import "Episode.h"

/*!
 @discussion This object defines the comment object.
 */
@interface Comment : NSObject <Deserialize>

@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, copy) NSString *body;
@property(nonatomic, strong) UserSynopsis *user;
@property(nonatomic, copy) NSString *uri;

@end

/*!
 @discussion This object defines the comments of one television show.
 */
@interface TvShowComments : Entity <Deserialize>

@property(nonatomic, strong) NSString *tvshowId;
@property(nonatomic, strong) NSArray *comments;

@end

/*!
 @discussion This object defines the comments of one television show.
 */ 
@interface EpisodeComments : Entity <Deserialize>

@property(nonatomic, strong) EpisodeId *episodeId;
@property(nonatomic, strong) NSArray *comments;

@end