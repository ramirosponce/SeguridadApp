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

+ (void) saveUser:(NSString*)mail password:(NSString*)password first_name:(NSString*)first_name last_name:(NSString*)last_name
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:mail forKey:@"user_mail"];
    [defaults setObject:password forKey:@"user_password"];
    [defaults setObject:password forKey:@"user_first_name"];
    [defaults setObject:password forKey:@"user_last_name"];
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

+ (NSString*) getUserFirstName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"user_first_name"];
}

+ (NSString*) getUserLastName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"user_last_name"];
}

+ (void) removeUser{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"user_mail"];
    [defaults removeObjectForKey:@"user_token"];
    [defaults removeObjectForKey:@"user_password"];
    [defaults synchronize];
}
@end
