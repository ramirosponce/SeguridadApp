//
//  AppHelper.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 25/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "AppHelper.h"

@implementation AppHelper

+ (BOOL) existObject:(NSString*)key in:(NSDictionary*)data
{
    if ([data objectForKey:key] != [NSNull null] & [data objectForKey:key] != nil){
        return YES;
    }
    return NO;
}

+ (BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,4})$";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+ (BOOL) NSStringLongestThan:(int)number string:(NSString *)checkString{
    
    if (checkString.length > number) {
        return YES;
    }
    return NO;
}

+ (NSString*) getUTCFormateDate:(NSDate*)localDate
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString* dateString = [dateFormatter stringFromDate:localDate];
    
    return dateString;
}

+ (NSString*) getTimeZoneNumber:(NSDate*)localDate
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"Z"];
    
    NSString* dateString = [dateFormatter stringFromDate:localDate];
    
    NSString* minutes_new_gtm = [dateString substringWithRange:NSMakeRange(3, 2)];
    //NSLog(@"minutos: %@", minutes_new_gtm);
    
    NSString* hour_new_gtm = [dateString substringWithRange:NSMakeRange(0, 3)];
    //NSLog(@"horas: %@", hour_new_gtm);
    
    int gtm_value = [hour_new_gtm intValue];
    
    int toal_gtm_value = ([hour_new_gtm intValue]*60) + [minutes_new_gtm intValue];
    NSString* gtm_parameter = [NSString stringWithFormat:@"%i",toal_gtm_value];
    if (gtm_value > 0) {
        gtm_parameter = [NSString stringWithFormat:@"+%i",toal_gtm_value];
    }
    
    return gtm_parameter;
}

+ (NSString*) getTimeZoneName
{
    return [[NSTimeZone localTimeZone] name];
}

@end
