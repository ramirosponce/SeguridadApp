//
//  NetworkAuxiliar.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 03/06/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkAuxiliarDelegate <NSObject>

- (void) connectionDidFinishSuccess:(NSString*) imagename;
- (void) connectionDidFinishError:(NSString*) error_message;

@end

@interface NetworkAuxiliar : NSObject <NSURLConnectionDelegate>

@property (nonatomic, assign) id <NetworkAuxiliarDelegate> delegate;

- (id) initWithDelegate:(id<NetworkAuxiliarDelegate>) del;

- (void) uploadPhotos:(UIImage*)image1 image2:(UIImage*)image2 image3:(UIImage*)image3 image4:(UIImage*)image4;
- (void) uploadPhoto:(UIImage*)image;
- (void) uploadVideo:(NSURL*)videoURL;

@end
