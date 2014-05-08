//
//  GlobalManager.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 08/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalManager : NSObject

// this is for filters
@property (nonatomic) DateFilterType datefilterType;
@property (nonatomic) BOOL categoryAllSelected;
@property (nonatomic, strong) NSMutableArray* category_filters;

+ (GlobalManager *) sharedManager;


// filters methods
- (BOOL) areCategoryFilters;
- (BOOL) isCategorySelected:(NSString*)category_id;

@end
