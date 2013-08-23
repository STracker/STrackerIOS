//
//  BaseViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 27/05/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

- (id)initWithData:(NSArray *)data
{
    self = [super init];
    if (self)
        _data = [[NSMutableArray alloc] initWithArray:data];
    
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
    
    // Set tableview field and add to controller.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    self.navigationItem.title = _tableTitle;
    _app = [[UIApplication sharedApplication] delegate];
    
    [self configureViewStyle];
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
    // Is necessary to do this, for set background tableview.
    _tableView.backgroundView = nil;
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND]];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    /*
     Without this, the last cell don't appear, because this controller is not an UITableViewController and 
     exists the top bar for navigation controller.
    */
    CGRect frame = _tableView.frame;
    frame.size.height -= 44; // 44 is the size of top bar.
    _tableView.frame = frame;
}

/*!
 @discussion This method sets the configuration of the table view cell.
 */
- (void)configureCellView:(UITableViewCell *)cell
{
    [cell.textLabel setFont:[UIFont fontWithName:@"Futura Medium" size:20.0]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
}

@end
