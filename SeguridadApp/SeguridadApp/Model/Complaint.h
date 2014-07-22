//
//  Complaint.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 06/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "User.h"

@interface Complaint : NSObject

@property (nonatomic, strong) NSString* complaint_id;
@property (nonatomic, strong) NSString* complaint_title;
@property (nonatomic, strong) NSString* complaint_date;
@property (nonatomic, strong) NSString* complaint_description;
@property (nonatomic, strong) Location* location;
@property (nonatomic) int affected;
@property (nonatomic) int isTrue;
@property (nonatomic) int isntTrue;
@property (nonatomic, strong) NSArray* pictures;
@property (nonatomic, strong) NSArray* tags;
@property (nonatomic, strong) NSMutableArray* comments;

@property (nonatomic, strong) NSArray* attachs;
@property (nonatomic) BOOL frecuentemente;
@property (nonatomic, strong) NSString* hora;
@property (nonatomic, strong) NSString* region;
@property (nonatomic, strong) NSString* iconname;

@property (nonatomic) BOOL isAnonymous;
@property (nonatomic, strong) User* user;

- (id) initWithData:(NSDictionary*)dictionary;

@end
