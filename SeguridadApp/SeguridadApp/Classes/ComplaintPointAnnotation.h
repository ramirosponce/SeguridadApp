//
//  ComplaintPointAnnotation.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class Complaint;

@interface ComplaintPointAnnotation : MKPointAnnotation

@property (nonatomic, strong) NSString* iconname;
@property (nonatomic, assign) Complaint* complaint;

@end
