//
//  DataHelper.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 05/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHelper : NSObject

+ (NSArray*) getMapData;
+ (NSArray*) getTimeFilterData;
+ (NSArray*) getCategoryFilterData;

@end
