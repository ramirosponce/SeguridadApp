//
//  NetworkManager.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 20/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "NetworkManager.h"
#import "Reachability.h"
#import "ComplaintType.h"
#import "Complaint.h"
#import "Region.h"
#import "ErrorHelper.h"

@implementation NetworkManager

+ (BOOL) connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

#pragma mark -
#pragma mark Common methods

+ (AFHTTPRequestSerializer *)serializer {
    AFHTTPRequestSerializer *customSerializer = [AFHTTPRequestSerializer serializer];
    //[customSerializer setValue:[RLStringsManager getTimeZoneName] forHTTPHeaderField:@"zone"];
    
    return customSerializer;
}

+ (void) GetRequest:(NSString*) endpoint params:(NSDictionary*)params username:(NSString*)username password:(NSString*)password token:(NSString*)token completitionHandler:(void (^)(AFHTTPRequestOperation *operation,id responseObject, NSError *error))completitionHandler
{
    NSString* url_string = [NSString stringWithFormat:@"%@%@",API_BASE_URL,endpoint];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:url_string parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completitionHandler(operation, responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completitionHandler(operation, nil, error);
    }];
}

+ (void) GetRequest:(NSString*) endpoint params:(NSDictionary*)params completitionHandler:(void (^)(AFHTTPRequestOperation *operation,id responseObject, NSError *error))completitionHandler
{
    [self GetRequest:endpoint params:params username:nil password:nil token:nil completitionHandler:completitionHandler];
}

+ (void) GetRequest:(NSString*) endpoint params:(NSDictionary*)params token:(NSString*)token completitionHandler:(void (^)(AFHTTPRequestOperation *operation,id responseObject, NSError *error))completitionHandler
{
    [self GetRequest:endpoint params:params username:nil password:nil token:token completitionHandler:completitionHandler];
}

+ (void) PostRequest:(NSString*) endpoint params:(NSDictionary*)params username:(NSString*)username password:(NSString*)password token:(NSString*)token completitionHandler:(void (^)(AFHTTPRequestOperation *operation,id responseObject, NSError *error))completitionHandler
{
    NSString* url_string = [NSString stringWithFormat:@"%@%@",API_BASE_URL,endpoint];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    if (token) {
        NSString* token_header = [NSString stringWithFormat:@"Bearer %@",token];
        [manager.requestSerializer setValue:token_header forHTTPHeaderField:@"Authorization"];
    }
    
    [manager POST:url_string parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completitionHandler(operation, responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completitionHandler(operation, nil, error);
    }];
}

+ (void) PostRequest:(NSString*) endpoint params:(NSDictionary*)params completitionHandler:(void (^)(AFHTTPRequestOperation *operation,id responseObject, NSError *error))completitionHandler
{
    [self PostRequest:endpoint params:params username:nil password:nil token:nil completitionHandler:completitionHandler];
}

+ (void) PostRequest:(NSString*) endpoint params:(NSDictionary*)params token:(NSString*)token completitionHandler:(void (^)(AFHTTPRequestOperation *operation,id responseObject, NSError *error))completitionHandler
{
    [self PostRequest:endpoint params:params username:nil password:nil token:token completitionHandler:completitionHandler];
}



#pragma mark -
#pragma mark Request methods

+ (void) runComplaintTypesRequest:(ComplaintTypeCompletionHandler)completitionHandler
{
    [self GetRequest:API_TIPO_DENUNCIAS params:nil completitionHandler:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (!error) {
            NSMutableArray* types = [NSMutableArray arrayWithCapacity:0];
            
            NSArray* response_array = (NSArray*)responseObject;
            for (NSDictionary* data in response_array) {
                ComplaintType* type = [[ComplaintType alloc] initWithData:data];
                [types addObject:type];
            }
            completitionHandler(types, nil);
        }else{
            completitionHandler(nil, error);
        }
    }];
}

+ (void) runRegionsRequest:(RegionsCompletionHandler)completitionHandler
{
    [self GetRequest:API_REGIONS params:nil completitionHandler:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (!error) {
            NSMutableArray* regions = [NSMutableArray arrayWithCapacity:0];
            NSArray* response_array = (NSArray*)responseObject;
            
            for (NSDictionary* data in response_array) {
                Region* region = [[Region alloc] initWithData:data];
                [regions addObject:region];
            }
            completitionHandler(regions, nil);
        }else{
            completitionHandler(nil, error);
        }
    }];
}

/*+ (void) runMapRequestWithLimit:(int)limit completition:(ComplaintMapCompletionHandler)completitionHandler
{
    NSDictionary* params = @{@"limit":[NSString stringWithFormat:@"%i",limit]};
    [self PostRequest:API_DENUNCIA_SEARCH params:params completitionHandler:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        
        if (!error) {
            //NSLog(@"%@", responseObject);
            NSMutableArray* complaints = [NSMutableArray arrayWithCapacity:0];
            
            NSArray* response_array = (NSArray*)responseObject;
            for (NSDictionary* data in response_array) {
                //NSLog(@"response denuncia: %@", data);
                Complaint* complaint = [[Complaint alloc] initWithData:data];
                [complaints addObject:complaint];
            }
            completitionHandler(complaints, nil);
        }else{
            completitionHandler(nil, error);
        }
        
    }];
}*/

+ (void) runSearchRequestWithParams:(NSDictionary*)params completition:(ComplaintMapCompletionHandler)completitionHandler
{
    [self PostRequest:API_DENUNCIA_SEARCH params:params completitionHandler:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        
        if (!error) {
            NSLog(@"%@", responseObject);
            NSMutableArray* complaints = [NSMutableArray arrayWithCapacity:0];
            
            NSArray* response_array = (NSArray*)responseObject;
            for (NSDictionary* data in response_array) {
                //NSLog(@"response denuncia: %@", data);
                Complaint* complaint = [[Complaint alloc] initWithData:data];
                [complaints addObject:complaint];
            }
            completitionHandler(complaints, nil);
        }else{
            completitionHandler(nil, error);
        }
        
    }];
}

+ (void) runFindById:(NSString*)byID completition:(ComplaintByIDCompletionHandler)completitionHandler
{
    NSDictionary* params = @{@"id":byID};
    [self PostRequest:API_DENUNCIA_FIND_BY_ID params:params completitionHandler:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        
        NSLog(@"Response: %@",responseObject);
        //NSLog(@"Error: %@",operation.responseObject);
        if (!error) {
            Complaint* complaint = [[Complaint alloc] initWithData:responseObject];
            completitionHandler(complaint.comments, nil);
        }else{
            completitionHandler(nil, error);
        }
        
    }];
}


+ (void) runSignupRequestWithParams:(NSDictionary*)params completition:(SignupCompletitionHandler)completitionHandler
{
    [self PostRequest:API_SIGNUP params:params completitionHandler:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        
        if (!error) {
            completitionHandler(responseObject, nil, nil);
        }else{
            NSString* err = [operation.responseObject objectForKey:@"err"];
            completitionHandler(nil, error, [ErrorHelper errorMessage:err]);
        }
        
    }];
}

+ (void) runLoginRequestWithParams:(NSDictionary*)params completition:(LoginCompletitionHandler)completitionHandler
{
    [self PostRequest:API_LOGIN params:params completitionHandler:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (!error) {
            completitionHandler(responseObject, nil, nil);
        }else{
            NSString* err = [operation.responseObject objectForKey:@"err"];
            completitionHandler(nil, error, [ErrorHelper errorMessage:err]);
        }
        
    }];
}

+ (void) runSendComplaintRequestWithParams:(NSDictionary*)params token:(NSString*)token completition:(SendComplaintCompletitionHandler)completitionHandler
{
    [self PostRequest:API_NEW params:params token:token completitionHandler:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        
        if (!error) {
            //NSLog(@"response ok: %@", responseObject);
            completitionHandler(responseObject, nil);
        }else{
            //NSLog(@"error: %@", operation.responseObject);
            completitionHandler(nil, error);
        }
    }];
}

+ (void) sendCommentWithParams:(NSDictionary*)params token:(NSString*)token completition:(SendCommentCompletitionHandler)completitionHandler
{
    [self PostRequest:API_UPDATE params:params token:token completitionHandler:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (!error) {
            completitionHandler(responseObject, nil, nil);
        }else{
            NSString* err = [operation.responseObject objectForKey:@"err"];
            completitionHandler(nil, error, [ErrorHelper errorMessage:err]);
        }
    }];
}

+ (void) sendAffectedWithParams:(NSDictionary*)params token:(NSString*)token completition:(AffectedCompletitionHandler)completitionHandler
{
    [self PostRequest:API_UPDATE params:params token:token completitionHandler:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (!error) {
            completitionHandler(responseObject, nil, nil);
        }else{
            NSString* err = [operation.responseObject objectForKey:@"err"];
            //NSLog(@"err: %@",err);
            completitionHandler(nil, error, [ErrorHelper errorMessage:err]);
        }
    }];
}

+ (void) sendIsTrueWithParams:(NSDictionary*)params token:(NSString*)token completition:(IsTrueCompletitionHandler)completitionHandler
{
    [self PostRequest:API_UPDATE params:params token:token completitionHandler:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (!error) {
            completitionHandler(responseObject, nil, nil);
        }else{
            NSString* err = [operation.responseObject objectForKey:@"err"];
            //NSLog(@"err: %@",err);
            completitionHandler(nil, error, [ErrorHelper errorMessage:err]);
        }
    }];
}

+ (void) sendIsNotTrueWithParams:(NSDictionary*)params token:(NSString*)token completition:(IsNotTrueCompletitionHandler)completitionHandler
{
    [self PostRequest:API_UPDATE params:params token:token completitionHandler:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (!error) {
            completitionHandler(responseObject, nil, nil);
        }else{
            NSString* err = [operation.responseObject objectForKey:@"err"];
            //NSLog(@"err: %@",err);
            completitionHandler(nil, error, [ErrorHelper errorMessage:err]);
        }
    }];
}

@end
