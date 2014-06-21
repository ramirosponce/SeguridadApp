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
        
        if ([AppHelper existObject:@"_id" in:data]) {
            self.user_id = [data objectForKey:@"_id"];
        }
        
        if ([AppHelper existObject:@"apellido" in:data]) {
            self.user_first_name = [data objectForKey:@"apellido"];
        }
        
        if ([AppHelper existObject:@"nombre" in:data]) {
            self.user_last_name = [data objectForKey:@"nombre"];
        }
        
        if ([AppHelper existObject:@"email" in:data]) {
            self.user_email = [data objectForKey:@"email"];
        }
        
        //self.user_id = [data objectForKey:@"_id"];
        //self.username = [data objectForKey:@"username"];
        //self.profile_image_name = [data objectForKey:@"picture"];
        
    }
    return self;
}

@end
