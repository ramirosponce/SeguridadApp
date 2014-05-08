//
//  CategoryFilter.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 08/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryFilter : NSObject

@property (nonatomic, strong) NSString * category_id;
@property (nonatomic, strong) NSString * name;
@property (nonatomic) BOOL isSelected;

- (id)initWithData:(NSDictionary *)dData;

@end
