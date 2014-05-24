//
//  ComplaintType.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 20/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "ComplaintType.h"

@implementation ComplaintType

//@property (nonatomic, strong) NSString* type_id;
//@property (nonatomic, strong) NSString* icon_name;
//@property (nonatomic, strong) NSString* name;
//@property (nonatomic, strong) NSArray*  subcategories;

//"_id" = 536c79694b9c10f0fb4be618;
//icon = "alcohol.png";
//nombre = "Art\U00edculos ilegales";
//subcategorias =         (
//                         Contrabando,
//                         Drogas,
//                         "Alcohol a menores",
//                         "Cosas robada"
//                         );

- (id)initWithData:(NSDictionary *)dData
{
    self = [super init];
    if (self) {
        
        if ([dData objectForKey:@"_id"]) {
            self.type_id = [dData objectForKey:@"_id"];
        }
        
        if ([dData objectForKey:@"icon"]) {
            self.icon_name = [dData objectForKey:@"icon"];
        }
        
        if ([dData objectForKey:@"nombre"]) {
            self.name = [dData objectForKey:@"nombre"];
        }
        
        if ([dData objectForKey:@"subcategorias"]) {
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
