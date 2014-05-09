//
//  GlobalManager.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 08/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CategoryFilter;

@interface GlobalManager : NSObject

// this is for filters
@property (nonatomic) DateFilterType datefilterType;
@property (nonatomic) BOOL categoryAllSelected;
@property (nonatomic, strong) NSMutableArray* category_filters;
@property (nonatomic, strong) NSMutableArray* categories;

+ (GlobalManager *) sharedManager;


// filters methods
- (BOOL) areCategoryFilters;
- (void) removeAllCategoryFilter;
- (BOOL) isCategorySelected:(NSString*)category_id;
- (void) loadCategories:(NSArray*) categories_temp;
- (void) removeCategoryFilter:(CategoryFilter*)category;

@end
