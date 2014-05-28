//
//  Region.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 28/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Region : NSObject

@property (nonatomic, strong) NSString* region_id;
@property (nonatomic, strong) NSString* region_name;
@property (nonatomic, strong) NSString* region_latitude;
@property (nonatomic, strong) NSString* region_longitude;

- (id)initWithData:(NSDictionary *)dData;

@end
