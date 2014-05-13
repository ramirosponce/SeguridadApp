//
//  User.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 13/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "User.h"

@implementation User

- (id) initWithData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        self.user_id = [data objectForKey:@"id"];
        self.username = [data objectForKey:@"username"];
        self.profile_image_name = [data objectForKey:@"picture"];
    }
    return self;
}

@end
