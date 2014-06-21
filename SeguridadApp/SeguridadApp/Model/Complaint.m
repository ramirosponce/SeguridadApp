//
//  Complaint.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 06/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "Complaint.h"
#import "Comment.h"

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
        
        if ([AppHelper existObject:@"hora" in:dictionary]) {
            self.hora = [dictionary objectForKey:@"hora"];
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
        
        if ([AppHelper existObject:@"attachs" in:dictionary]) {
            if ([[dictionary objectForKey:@"attachs"] isKindOfClass:[NSArray class]]) {
                self.attachs = [dictionary objectForKey:@"attachs"];//
            }
        }
        
        if ([AppHelper existObject:@"tags" in:dictionary]) {
            self.tags = [dictionary objectForKey:@"tags"];//
        }
        
        if ([AppHelper existObject:@"comentarios" in:dictionary]) {
            //comments
            self.comments = [[NSMutableArray alloc] initWithCapacity:0];
            NSArray* comments_aux = [dictionary objectForKey:@"comentarios"];
            for (NSDictionary* data in comments_aux) {
                Comment* comment = [[Comment alloc] initWithData:data];
                [self.comments addObject:comment];
            }
        }
        
        if ([AppHelper existObject:@"frecuentemente" in:dictionary]) {
            self.frecuentemente = [[dictionary objectForKey:@"frecuentemente"] boolValue];
        }
        
        self.isAnonymous = YES;
        
        //self.isAnonymous = [[dictionary objectForKey:@"isAnonymous"] boolValue];
        //self.user = [[User alloc] initWithData:[dictionary objectForKey:@"user"]];
    }
    return self;
}

@end
