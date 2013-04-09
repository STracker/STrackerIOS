//
//  ViewController.m
//  STracker
//
//  Created by Ricardo Sousa on 09/04/13.
//  Copyright (c) 2013 Ricardo Sousa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [showSeasonsButton setEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (IBAction)getInfo:(id)sender
{
    [getInfoButton setEnabled:NO];
    [showSeasonsButton setEnabled:NO];
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("get_info...", nil);
    
    dispatch_async(downloadQueue, ^{
        
        NSURL *url = [NSURL URLWithString:@"http://strackerserverdev.apphb.com/api/tvshows/tt1520211"];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        NSError *error = nil;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if (!result)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error retrieving data" message:nil delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            tvshow = [[TvShow alloc] init];
            [tvshow setId:[result objectForKey:@"Id"]];
            [tvshow setName:[result objectForKey:@"Name"]];
            [tvshow setDescription:[result objectForKey:@"Description"]];
            
            tvshow.Actors = [[NSMutableArray alloc] init];
            NSDictionary *actors = [result objectForKey:@"Actors"];
            for (NSDictionary *item in actors)
            {
                Actor *actor = [[Actor alloc] init];
                [actor setName:[item objectForKey:@"Name"]];
                [actor setCharacterName:[item objectForKey:@"CharacterName"]];
                [tvshow.Actors addObject:actor];
            }
            
            tvshow.Seasons = [[NSMutableArray alloc] init];
            NSDictionary *seasons = [result objectForKey:@"SeasonSynopses"];
            for(NSDictionary *item in seasons)
            {
                Season *season = [[Season alloc] init];
                [season setNumber:[[item objectForKey:@"Number"] intValue]];
                [tvshow.Seasons addObject:season];
            }
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            
            tvShowName.text = tvshow.Name;
            infoSummary.text = [NSString stringWithFormat:@"Id:%@\nDescription:%@\n\nActors:\n", tvshow.Id, tvshow.Description];
            
            for (Actor *actor in tvshow.Actors) {
                infoSummary.text = [infoSummary.text stringByAppendingString:[NSString stringWithFormat:@"\nName:%@\nCharacterName:%@\n", actor.Name, actor.CharacterName]];
            }
            
            [getInfoButton setEnabled:YES];
            [showSeasonsButton setEnabled:YES];
        });
    });

}

- (IBAction)showSeasons:(id)sender
{
    SeasonsTableViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SeasonsTableView"];
    
    [view setSeasons:tvshow.Seasons];
    
    [self.navigationController pushViewController:view animated:YES];
}

@end
