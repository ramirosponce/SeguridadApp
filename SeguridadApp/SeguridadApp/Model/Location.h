//
//  Location.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 06/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject;

@property (nonatomic, strong) NSString* longitude;
@property (nonatomic, strong) NSString* latitude;

- (id) initWithData:(NSDictionary*)dictionary;

@end
