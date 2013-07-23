//
//  BaseViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController

- (id)initWithData:(NSArray *)data
{
    self = [super init];
    if (self)
        _data = data;
    
    return self;
}

- (id)initWithData:(NSArray *)data andTitle:(NSString *)title
{
    if (self = [self initWithData:data])
        _tableTitle = title;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = _tableTitle;
    _app = [[UIApplication sharedApplication] delegate];
    
    [self configureViewStyle];
}

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

#pragma mark - Table view data source.

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLIDENTIFIER];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLIDENTIFIER];
    
    [self configureCellView:cell];
    [self configureCellHook:cell inIndexPath:indexPath];
    
    return cell;
}

#pragma mark - BaseTableViewController private auxiliary methods.

/*!
 @discussion This method sets the configuration of the table view.
 */
- (void)configureViewStyle
{
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

/*!
 @discussion This method sets the configuration of the table view cell.
 */
- (void)configureCellView:(UITableViewCell *)cell
{
    [cell.textLabel setFont:[UIFont fontWithName:@"Tamil Sangam MN" size:22.0]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
}

@end
