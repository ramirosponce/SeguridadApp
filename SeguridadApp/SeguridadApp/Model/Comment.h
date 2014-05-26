//
//  Comment.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 14/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"


@interface Comment : NSObject

@property (nonatomic, strong) NSString * comment_id;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) User* user;
@property (nonatomic, strong) NSDate* date;

- (id)initWithData:(NSDictionary *)dData;

@end
