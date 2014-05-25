//
//  Complaint.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 06/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "Complaint.h"

@implementation Complaint

- (id) initWithData:(NSDictionary*)dictionary{
    self = [super init];
    if (self != nil) {
        
        if ([AppHelper existObject:@"_id" in:dictionary]) {
            self.complaint_id = [dictionary objectForKey:@"_id"];
        }
        
        if ([AppHelper existObject:@"titulo" in:dictionary]) {
            self.complaint_title = [dictionary objectForKey:@"titulo"];
        }
        
        if ([AppHelper existObject:@"fecha" in:dictionary]) {
            self.complaint_date = [dictionary objectForKey:@"fecha"];//
        }
        
        if ([AppHelper existObject:@"descripcion" in:dictionary]) {
            self.complaint_description = [dictionary objectForKey:@"descripcion"];//
        }
        
        if ([AppHelper existObject:@"pos" in:dictionary]) {
            self.location = [[Location alloc] initWithData:[dictionary objectForKey:@"pos"]];//
        }
        
        if ([AppHelper existObject:@"afectados" in:dictionary]) {
            self.affected = [[dictionary objectForKey:@"afectados"] intValue];//
        }
        
        if ([AppHelper existObject:@"escierto" in:dictionary]) {
            self.isTrue = [[dictionary objectForKey:@"escierto"] intValue];//
        }
        
        if ([AppHelper existObject:@"nocierto" in:dictionary]) {
            self.isntTrue = [[dictionary objectForKey:@"nocierto"] intValue];//
        }
        
        if ([AppHelper existObject:@"fotos" in:dictionary]) {
            self.pictures = [dictionary objectForKey:@"fotos"];//
        }
        
        if ([AppHelper existObject:@"tags" in:dictionary]) {
            self.tags = [dictionary objectForKey:@"tags"];//
        }
        
        //self.isAnonymous = [[dictionary objectForKey:@"isAnonymous"] boolValue];
        //self.user = [[User alloc] initWithData:[dictionary objectForKey:@"user"]];
    }
    return self;
}

@end
