//
//  SubscriptionViewController.h
//  STracker
//
//  Created by Ricardo Sousa on 8/23/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "BaseTableViewController.h"
#import "Subscription.h"

/*!
 @discussion View for show the subscription, shows the watched episodes.
 */
@interface SubscriptionViewController : BaseTableViewController
{
    @private
    Subscription *_subscription;
}

/*!
 @discussion Init method that receives the subscription.
 @param subscription    The subscription information.
 @return An instance of SubscriptionViewController.
 */
- (id)initWithSubscription:(Subscription *)subscription;

@end
