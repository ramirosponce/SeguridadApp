//
//  Region.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 28/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "Region.h"

@implementation Region

- (id)initWithData:(NSDictionary *)dData
{
    self = [super init];
    if (self) {
        
        if ([AppHelper existObject:@"_id" in:dData]) {
            self.region_id = [dData objectForKey:@"_id"];
        }
        
        if ([AppHelper existObject:@"lbl" in:dData]) {
            self.region_name = [dData objectForKey:@"lbl"];
        }
        
        if ([AppHelper existObject:@"lat" in:dData]) {
            self.region_latitude = [dData objectForKey:@"lat"];
        }
        
        if ([AppHelper existObject:@"lng" in:dData]) {
            self.region_longitude = [dData objectForKey:@"lng"];
        }
    }
    return self;
}

@end
