//
//  GlobalManager.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 08/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "GlobalManager.h"
#import "CategoryFilter.h"

@implementation GlobalManager

static GlobalManager * sharedInstance = nil;

#pragma mark - 
#pragma mark Singleton methods

-(id)init
{
    if(self = [super init])
    {
        /* Init Singleton */
        
        
        // inicializacion para los datos de filtro
        self.datefilterType = kDateFilterToday;
        self.categoryAllSelected = YES;
        self.category_filters = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return nil;
}

+(GlobalManager *)sharedManager
{
    @synchronized (self)
    {
		if (sharedInstance == nil)
			[[self alloc] init];
	}
	return sharedInstance;
}

#pragma mark -
#pragma mark load methods

#pragma mark -
#pragma mark Filters methods

- (BOOL) areCategoryFilters
{
    if ([self.category_filters count] > 0) {
        return YES;
    }
    return NO;
}

- (void) removeAllCategoryFilter
{
    self.category_filters = [[NSMutableArray alloc] initWithCapacity:0];
}

- (BOOL) isCategorySelected:(NSString*)category_id
{
    for (CategoryFilter* category_selected in self.category_filters) {
        
        if ([category_selected.category_id isEqualToString:category_id]) {
            return YES;
        }
    }
    return NO;
}

@end
