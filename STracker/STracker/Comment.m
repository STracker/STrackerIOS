//
//  Comment.m
//  STracker
//
//  Created by Ricardo Sousa on 7/9/13.
//  Copyright (c) 2013 STracker. All rights reserved.
//

#import "Comment.h"

@implementation Comment

@synthesize identifier, body, user, uri;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        identifier = [parameters objectForKey:@"Id"];
        body = [parameters objectForKey:@"Body"];
        user = [[UserSynopsis alloc] initWithDictionary:[parameters objectForKey:@"User"]];
        uri = [parameters objectForKey:@"Uri"];
    }  
    
    return self;
}

@end

@implementation TvShowComments

@synthesize tvshowId, comments;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        tvshowId = [parameters objectForKey:@"Id"];
        
        NSMutableArray *commentsAux = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"Comments"])
        {
            Comment *comment = [[Comment alloc] initWithDictionary:item];
            [commentsAux addObject:comment];
        }
        comments = commentsAux;
    }
    
    return self;
}

@end

@implementation EpisodeComments

@synthesize episodeId, comments;

- (id)initWithDictionary:(NSDictionary *)parameters
{
    if (self = [super init])
    {
        episodeId = [[EpisodeId alloc] initWithDictionary:[parameters objectForKey:@"Id"]];
        
        NSMutableArray *commentsAux = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [parameters objectForKey:@"Comments"])
        {
            Comment *comment = [[Comment alloc] initWithDictionary:item];
            [commentsAux addObject:comment];
        }
        comments = commentsAux;
    }
    
    return self;
}

@end