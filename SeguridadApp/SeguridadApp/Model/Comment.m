//
//  Comment.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 14/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "Comment.h"

@implementation Comment

- (id) initWithData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        self.comment_id = [data objectForKey:@"id"];
        self.text = [data objectForKey:@"text"];
        self.user = [[User alloc] initWithData:[data objectForKey:@"user"]];
    }
    return self;
}

@end
