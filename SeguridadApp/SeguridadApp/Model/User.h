//
//  User.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 13/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString * user_id;
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * profile_image_name;

@property (nonatomic, strong) NSString * user_first_name;
@property (nonatomic, strong) NSString * user_last_name;
@property (nonatomic, strong) NSString * user_email;

- (id)initWithData:(NSDictionary *)dData;

@end
