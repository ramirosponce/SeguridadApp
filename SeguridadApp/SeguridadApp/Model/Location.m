//
//  Location.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 06/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "Location.h"

@implementation Location

- (id) initWithData:(NSDictionary*)dictionary
{
    self = [super init];
    if (self != nil) {
        self.longitude = [dictionary objectForKey:@"lon"];
        self.latitude = [dictionary objectForKey:@"lat"];
        
    }
    return self;
}

@end
