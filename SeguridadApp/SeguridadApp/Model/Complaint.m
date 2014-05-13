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
        self.complaint_id = [dictionary objectForKey:@"id"];
        self.complaint_title = [dictionary objectForKey:@"title"];
        self.complaint_date = [dictionary objectForKey:@"datetime"];
        self.complaint_description = [dictionary objectForKey:@"description"];
        self.location = [[Location alloc] initWithData:[dictionary objectForKey:@"location"]];
        self.affected = [[dictionary objectForKey:@"affected"] intValue];
        self.isTrue = [[dictionary objectForKey:@"isTrue"] intValue];
        self.isntTrue = [[dictionary objectForKey:@"isntTrue"] intValue];
        self.pictures = [dictionary objectForKey:@"pictures"];
        self.tags = [dictionary objectForKey:@"tags"];
        self.isAnonymous = [[dictionary objectForKey:@"isAnonymous"] boolValue];
        self.user = [[User alloc] initWithData:[dictionary objectForKey:@"user"]];
    }
    return self;
}

@end
