//
//  SuggestViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 18/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "PersonsViewController.h"

/*!
 @discussion Controller with list of user's friends,
 when a friend is choosed, sends to him the suggestion.
 */
@interface SuggestViewController : PersonsViewController
{
    @private
    NSString *_tvshowId;
}

/*!
 @discussion Init method that receives the list of friends 
 and the television show identifier.
 @param data        The friends.
 @param tvshowId    The television show id.
 @return An SuggestViewController.
 */
- (id)initWithData:(NSArray *)data andTvShowId:(NSString *) tvshowId;

@end
