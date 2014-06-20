//
//  DataHelper.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 05/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "DataHelper.h"
#import "CategoryFilter.h"
#import "Comment.h"
#import "ComplaintType.h"
#import "Region.h"

@implementation DataHelper

+ (NSArray*) getTimeFilterData
{
    NSArray* data = @[
                      @{@"title": NSLocalizedString(@"Today", @"Today")},
                      @{@"title": NSLocalizedString(@"Last Week", @"Last Week")},
                      @{@"title": NSLocalizedString(@"Last Month", @"Last Month")},
                      @{@"title": NSLocalizedString(@"All", @"All")},
                      ];
    return data;
}

+ (NSArray*) getCategoriesData
{
    NSString* plistPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Categories.plist"];
    if (plistPath != nil) {
        NSArray* categories = [NSArray arrayWithContentsOfFile:plistPath];
        NSMutableArray* types = [NSMutableArray arrayWithCapacity:0];
        
        for (NSDictionary* data in categories) {
            ComplaintType* type = [[ComplaintType alloc] initWithData:data];
            [types addObject:type];
        }
        
        return types;
    }
    return nil;
}

+ (NSArray*) getRegionsData
{
    NSString* plistPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Regions.plist"];
    if (plistPath != nil) {
        NSArray* regions_data = [NSArray arrayWithContentsOfFile:plistPath];
        NSMutableArray* regions = [NSMutableArray arrayWithCapacity:0];
        
        for (NSDictionary* data in regions_data) {
            Region* region = [[Region alloc] initWithData:data];
            [regions addObject:region];
        }
        
        return regions;
    }
    return nil;
}

@end
