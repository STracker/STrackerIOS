//
//  BaseViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController

- (void)viewDidLoadHook
{
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [_indicator setCenter:self.view.center];
    [self.view addSubview:_indicator];

}

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

- (void)configureViewStyle
{
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)configureCellView:(UITableViewCell *)cell
{
    [cell.textLabel setFont:[UIFont fontWithName:@"Tamil Sangam MN" size:22.0]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
}

- (id)initWithData:(NSMutableArray *)data
{
    self = [super init];
    if (self)
        _data = data;
    
    return self;
}

- (void)startAnimating
{
    [_indicator startAnimating];
}

- (void)stopAnimating
{
    [_indicator stopAnimating];
    
    // Release the pointer.
    _indicator = nil;
}

# pragma mark - UIView Controller delegate.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self viewDidLoadHook];
    [self configureViewStyle];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLIDENTIFIER];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLIDENTIFIER];
    
    [self configureCellView:cell];
    [self configureCellHook:cell inIndexPath:indexPath];
    
    return cell;
}

@end
