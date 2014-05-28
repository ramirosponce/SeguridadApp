//
//  ComplaintType.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 20/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComplaintType : NSObject

@property (nonatomic, strong) NSString* type_id;
@property (nonatomic, strong) NSString* icon_name;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSArray*  subcategories;
@property (nonatomic) BOOL isSelected;

- (id)initWithData:(NSDictionary *)dData;

@end
