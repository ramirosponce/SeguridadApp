//
//  Complaint.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 06/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface Complaint : NSObject

@property (nonatomic, strong) NSString* complaint_id;
@property (nonatomic, strong) NSString* complaint_title;
@property (nonatomic, strong) NSDate* complaint_date;
@property (nonatomic, strong) NSString* complaint_description;
@property (nonatomic, strong) Location* location;
@property (nonatomic) int affected;
@property (nonatomic) int isTrue;
@property (nonatomic) int isntTrue;
@property (nonatomic, strong) NSArray* pictures;
@property (nonatomic, strong) NSArray* tags;

- (id) initWithData:(NSDictionary*)dictionary;

@end