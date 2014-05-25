//
//  UserHelper.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 25/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "UserHelper.h"

@implementation UserHelper

+ (void) saveUser:(NSString*)mail password:(NSString*)password
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:mail forKey:@"user_mail"];
    [defaults setObject:password forKey:@"user_password"];
    [defaults synchronize];
}

+ (void) saveToken:(NSString*)token
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"user_token"];
    [defaults synchronize];
}

+ (NSString*) getUserMailSaved
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"user_mail"];
}

+ (NSString*) getUserPassword
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"user_password"];
}

+ (NSString*) getUserToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"user_token"];
}

@end
