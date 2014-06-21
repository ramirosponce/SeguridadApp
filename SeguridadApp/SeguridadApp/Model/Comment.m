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
        
        if ([AppHelper existObject:@"_id" in:data]) {
            self.comment_id = [data objectForKey:@"_id"];
        }
        
        if ([AppHelper existObject:@"texto" in:data]) {
            self.text = [data objectForKey:@"texto"];
        }
        
        
        if ([AppHelper existObject:@"usr" in:data]) {
            self.user = [[User alloc] initWithData:[data objectForKey:@"usr"]];
        }
        
        
        if ([AppHelper existObject:@"fecha" in:data]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
            self.date = [dateFormatter dateFromString:[data objectForKey:@"fecha"]];
            //[dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
            //[dateFormatter setDateFormat: @"MMM dd HH:mm"];
            //NSLog(@"fecha comment: %@ - %@", [dateFormatter stringFromDate:self.date], self.text);
        }
    }
    return self;
}

@end
