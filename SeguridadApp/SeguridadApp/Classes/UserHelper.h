//
//  UserHelper.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 25/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserHelper : NSObject

+ (void) saveUser:(NSString*)mail password:(NSString*)password;
+ (void) saveUser:(NSString*)mail password:(NSString*)password first_name:(NSString*)first_name last_name:(NSString*)last_name;
+ (void) saveToken:(NSString*)token;

+ (NSString*) getUserMailSaved;
+ (NSString*) getUserPassword;
+ (NSString*) getUserToken;
+ (NSString*) getUserFirstName;
+ (NSString*) getUserLastName;
+ (void) removeUser;

@end
