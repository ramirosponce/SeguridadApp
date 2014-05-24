//
//  Location.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 06/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "Location.h"

@implementation Location

- (id) initWithData:(NSString*)location_string
{
    self = [super init];
    if (self != nil) {
        NSArray *location = [location_string componentsSeparatedByString:@","];
        self.latitude = [location objectAtIndex:0];
        self.longitude = [location objectAtIndex:1];
    }
    return self;
}

@end
