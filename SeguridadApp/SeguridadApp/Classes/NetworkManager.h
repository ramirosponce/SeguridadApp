//
//  NetworkManager.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 20/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

typedef void (^ComplaintTypeCompletionHandler)(NSArray* types, NSError *error);
typedef void (^ComplaintMapCompletionHandler)(NSArray* map_complaints, NSError *error);
typedef void (^SignupCompletitionHandler)(NSDictionary* data, NSError* error);
typedef void (^LoginCompletitionHandler) (NSDictionary* data, NSError* error);

@interface NetworkManager : NSObject

+ (BOOL) connected;

+ (void) runComplaintTypesRequest:(ComplaintTypeCompletionHandler)completitionHandler;

+ (void) runMapRequestWithLimit:(int)limit completition:(ComplaintMapCompletionHandler)completitionHandler;

+ (void) runSignupRequestWithParams:(NSDictionary*)params completition:(SignupCompletitionHandler)completitionHandler;

+ (void) runLoginRequestWithParams:(NSDictionary*)params completition:(LoginCompletitionHandler)completitionHandler;

@end
