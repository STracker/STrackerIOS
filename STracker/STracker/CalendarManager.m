//
//  CalendarManager.m
//  STracker
//
//  Created by Ricardo Sousa on 25/08/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "CalendarManager.h"
#import "UsersRequests.h"
#import "UserCalendarData.h"
#import "UserCalendar.h"
#import "AsyncQueue.h"

@implementation CalendarManager

- (id)initWithContext:(NSManagedObjectContext *)context
{
    if (self = [super init])
        _context = context;
    
    return self;
}

- (void)getUserCalendar:(Finish)finish
{
    // Verify if exists in memory.
    if (_calendar != nil && [_calendar.entries count] > 0)
    {
        finish(_calendar);
        return;
    }
    // Verify in BD.
    UserCalendar *calendar = [self read];
    if (calendar != nil && [calendar.entries count] > 0)
    {
        finish(calendar);
        return;
    }
    
    [UsersRequests getUserCalendar:^(UserCalendar *calendar) {
    
        // Set memory variable.
        _calendar = calendar;
        // Create in DB.
        [self createAsync:calendar];
    
        finish(_calendar);
    }];
}

- (void)syncUserCalendar:(Finish)finish
{
    [UsersRequests getUserCalendar:^(UserCalendar *calendar) {
        
        // Set memory variable.
        _calendar = calendar;
        // Update in DB.
        [self updateAsync:calendar];
        
        finish(_calendar);
    }];
}

- (void)removeCalendar
{
    // Set memory variable to nil.
    _calendar = nil;
    
    // Remove from DB.
    [self remove];
}

#pragma mark - UserCalendar auxiliary private methods.

/*!
 @discussion Create method.
 @param calendar    The calendar to store in DB.
 */
- (void)create:(UserCalendar *) calendar
{
    UserCalendarData *newData = [NSEntityDescription insertNewObjectForEntityForName:@"UserCalendarData" inManagedObjectContext:_context];
    [self parseCalendar:calendar toCalendarData:newData];
    
    NSError *error;
    [_context save:&error];
    if (error)
    {
        NSLog(@"error create: %@", error.description);
        return;
    }
}

/*!
 @discussion Async version of create method.
 @param calendar    The calendar to store in DB.
 */
- (void)createAsync:(UserCalendar *) calendar
{
    [[AsyncQueue sharedObject] performAsyncOperation:^{
        
        [self create:calendar];
    }];
}

/*!
 @discussion Read method, returns the UserCalendar from DB.
 */
- (UserCalendar *)read
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserCalendarData" inManagedObjectContext:_context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [_context executeFetchRequest:fetchRequest error:&error];
    if (error || [fetchedObjects count] == 0)
    {
        NSLog(@"error read: %@", error.description);
        return nil;
    }
    
    UserCalendarData *uData = [fetchedObjects objectAtIndex:0]; // Only have one...
    
    // avail for set memory variable to...
    [self parseCalendarData:uData];
    return _calendar;
}

/*!
 @discussion Update method with assync execution.
 @param calendar    The new calendar information.
 */
- (void)updateAsync:(UserCalendar *)calendar
{
    [[AsyncQueue sharedObject] performAsyncOperation:^{
        
        [self remove];
        [self create:calendar];
    }];
}

/*!
 @discussion Remove method.
 */
- (void)remove
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserCalendarData" inManagedObjectContext:_context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [_context executeFetchRequest:fetchRequest error:&error];
    if (error || [fetchedObjects count] == 0)
    {
        NSLog(@"error remove: %@", error.description);
        return;
    }
    
    UserCalendarData *uData = [fetchedObjects objectAtIndex:0]; // Only have one...
    
    [_context deleteObject:uData];
    
    // Perform action.
    [_context save:&error];
    if (error)
        NSLog(@"error remove: %@", error.description);
}

/*!
 @discussion Auxiliary method for parse UserCalendar to UserCalendarData.
 @param calendar    The UserCalendar.
 @param newData     The UserCalendarData.
 */
- (void)parseCalendar:(UserCalendar *)calendar toCalendarData:(UserCalendarData *) newData
{
    newData.calendar = calendar;
}

/*!
 @discussion Auxiliary method for parse UserCalendarData to _calendar.
 @param calendarData    The UserCalendarData.
 */
- (void)parseCalendarData:(UserCalendarData *)calendarData
{
    _calendar = calendarData.calendar;
}

@end
