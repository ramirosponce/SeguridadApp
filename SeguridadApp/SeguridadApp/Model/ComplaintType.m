//
//  ComplaintType.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 20/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "ComplaintType.h"

@implementation ComplaintType

- (id)initWithData:(NSDictionary *)dData
{
    self = [super init];
    if (self) {
        
        if ([AppHelper existObject:@"_id" in:dData]) {
            self.type_id = [dData objectForKey:@"_id"];
        }
        
        if ([AppHelper existObject:@"icon" in:dData]) {
            self.icon_name = [dData objectForKey:@"icon"];
        }
        
        if ([AppHelper existObject:@"nombre" in:dData]) {
            self.name = [dData objectForKey:@"nombre"];
        }
        
        if ([AppHelper existObject:@"subcategorias" in:dData]) {
            self.subcategories = [[NSArray alloc] initWithArray:[dData objectForKey:@"subcategorias"]];
        }
        
        // esta variable es para el manejo de filtros
        self.isSelected = YES;
    }
    return self;
}

- (NSString*) description{
    return [NSString stringWithFormat:@"id: %@, icon: %@, name: %@, subcategories: %@",self.type_id, self.icon_name,self.name, self.subcategories];
}

@end
