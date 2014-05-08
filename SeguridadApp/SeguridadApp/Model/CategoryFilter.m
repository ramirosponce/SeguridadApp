//
//  CategoryFilter.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 08/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "CategoryFilter.h"

@implementation CategoryFilter

- (id) initWithData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        self.category_id = [data objectForKey:@"id"];
        self.name = [data objectForKey:@"name"];
    }
    return self;
}

@end
