//
//  GlobalManager.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 08/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ComplaintType;

@interface GlobalManager : NSObject

// this is for filters
@property (nonatomic) DateFilterType datefilterType;
@property (nonatomic) BOOL categoryAllSelected;
@property (nonatomic, strong) NSMutableArray* category_filters;
@property (nonatomic, strong) NSMutableArray* categories;

// this is for load content
@property (nonatomic, strong) NSArray* complaint_types;

+ (GlobalManager *) sharedManager;


// load methods
- (void) saveComplaintTypes:(NSArray*)types;

// filters methods
- (BOOL) areCategoryFilters;
- (void) removeAllCategoryFilter;
- (BOOL) isCategorySelected:(NSString*)category_id;
- (void) loadCategories:(NSArray*) categories_temp;
- (void) removeCategoryFilter:(ComplaintType*)category;

@end
