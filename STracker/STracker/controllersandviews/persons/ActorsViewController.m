//
//  ActorsViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 7/22/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "ActorsViewController.h"
#import "Actor.h"

@implementation ActorsViewController

- (void)configureCellHook:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
    [super configureCellHook:cell inIndexPath:indexPath];
    
    Actor *actor = [_data objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = actor.characterName;
}

@end
