//
//  CalendarManager.h
//  STracker
//
//  Created by Ricardo Sousa on 25/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@class UserCalendar;

/*!
 @discussion Class that manage the user calendar.
 Use Core Data framework.
 @see http://developer.apple.com/library/ios/DOCUMENTATION/Cocoa/Conceptual/CoreData/cdProgrammingGuide.html
 */
@interface CalendarManager : NSObject
{
    // Memory variable, for fast access.
    @private UserCalendar *_calendar;
    
    /*
     context for manage the data through Core Data.
     */
    @private NSManagedObjectContext *_context;
}

/*!
 @discussion Initializes the object.
 @param context The managed context.
 @return an CalendarManager instance.
 */
- (id)initWithContext:(NSManagedObjectContext *) context;

/*!
 @discussion Gets the user calendar.
 @param finish  The finish callback.
 */
- (void)getUserCalendar:(Finish) finish;

/*!
 @discussion Performs the synchronization of the calendar
 with server.
 @param finish  The finish callback.
 */
- (void)syncUserCalendar:(Finish) finish;

/*!
 @discussion Remove the calendar from memory and DB.
 */
- (void)removeCalendar;

@end
