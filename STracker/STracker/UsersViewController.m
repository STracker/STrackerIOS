//
//  UsersViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 10/07/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "UsersViewController.h"
#import "User.h"

@implementation UsersViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserSinopse *synopse = [_data objectAtIndex:indexPath.row];
    
    NSLog(@"selected %@ user", synopse.name);
    
    // TODO...
}

@end
