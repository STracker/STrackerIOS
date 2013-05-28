//
//  BaseViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
        [self initHook];
    
    return self;
}

- (id)init
{
    if (self = [super init])
        [self initHook];
    
    return self;
}

- (void)initHook
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

- (void)viewDidLoadHook
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

# pragma mark - UIView Controller delegate.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    
    [self viewDidLoadHook];
}

#pragma mark - Table view data source.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellIdentifier];
    
    [self configureCellHook:cell inIndexPath:indexPath];
    
    return cell;
}

@end
