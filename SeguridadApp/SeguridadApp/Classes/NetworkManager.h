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
typedef void (^RegionsCompletionHandler)(NSArray* regions, NSError *error);
typedef void (^ComplaintMapCompletionHandler)(NSArray* map_complaints, NSError *error);
typedef void (^SignupCompletitionHandler)(NSDictionary* data, NSError* error, NSString* error_message);
typedef void (^LoginCompletitionHandler) (NSDictionary* data, NSError* error, NSString* error_message);
typedef void (^SendComplaintCompletitionHandler) (NSDictionary* data, NSError* error);

typedef void (^SendCommentCompletitionHandler) (NSDictionary* data, NSError* error, NSString* error_message);


@interface NetworkManager : NSObject

+ (BOOL) connected;

+ (void) runComplaintTypesRequest:(ComplaintTypeCompletionHandler)completitionHandler;

+ (void) runRegionsRequest:(RegionsCompletionHandler)completitionHandler;

+ (void) runMapRequestWithLimit:(int)limit completition:(ComplaintMapCompletionHandler)completitionHandler;

+ (void) runSignupRequestWithParams:(NSDictionary*)params completition:(SignupCompletitionHandler)completitionHandler;

+ (void) runLoginRequestWithParams:(NSDictionary*)params completition:(LoginCompletitionHandler)completitionHandler;

+ (void) runSendComplaintRequestWithParams:(NSDictionary*)params completition:(SendComplaintCompletitionHandler)completitionHandler;

+ (void) sendCommentWithParams:(NSDictionary*)params token:(NSString*)token completition:(SendCommentCompletitionHandler)completitionHandler;

@end
