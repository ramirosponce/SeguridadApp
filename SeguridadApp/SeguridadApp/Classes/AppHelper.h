//
//  AppHelper.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 25/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppHelper : NSObject

+ (BOOL) existObject:(NSString*)key in:(NSDictionary*)data;

+ (BOOL) NSStringIsValidEmail:(NSString *)checkString;

+ (NSString*) getUTCFormateDate:(NSDate*)localDate;

+ (NSString*) getTimeZoneNumber:(NSDate*)localDate;

+ (NSString*) getTimeZoneName;

@end
