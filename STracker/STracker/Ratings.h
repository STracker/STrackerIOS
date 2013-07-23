//
//  Ratings.h
//  STracker
//
//  Created by Ricardo Sousa on 7/22/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

/*!
 @discussion This object controls the rating 
 information.
 */
@interface Ratings : NSObject
{
    AppDelegate *_app;
    
    UILabel *_average;
    UILabel *_numberOfUsers;
}

/*!
 @discussion This constructor creates an instance of Ratings. 
 Receives the labels average and number of users from the view controllers 
 that have rating information.
 @param average         Label with average rating information.
 @param numberOfUsers   Label with total users that have one rating.
 */
- (id)initWithAverage:(UILabel *)average andNumberOfUsers:(UILabel *)numberOfUsers;

/*!
 @discussion This method allows to get and set the labels with 
 rating information. The uri parameter is for request the information 
 in STracker server.
 @param uri The request uri. Normally from tv show or episode.
 */
- (void)getRating:(NSString *)uri;

/*!
 @discussion This method allows to put user rating information
 in STracker server.
 @param uri     The request uri. Normally from tv show or episode.
 @param rating  The user's rating.
 */
- (void)postRating:(NSString *)uri withRating:(float)rating;

@end