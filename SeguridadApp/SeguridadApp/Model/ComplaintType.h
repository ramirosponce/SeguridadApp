//
//  ComplaintType.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 20/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComplaintType : NSObject

//"_id" = 536c79694b9c10f0fb4be618;
//icon = "alcohol.png";
//nombre = "Art\U00edculos ilegales";
//subcategorias =         (
//                         Contrabando,
//                         Drogas,
//                         "Alcohol a menores",
//                         "Cosas robada"
//                         );

@property (nonatomic, strong) NSString* type_id;
@property (nonatomic, strong) NSString* icon_name;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSArray*  subcategories;
@property (nonatomic) BOOL isSelected;

- (id)initWithData:(NSDictionary *)dData;

@end
