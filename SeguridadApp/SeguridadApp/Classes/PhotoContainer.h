//
//  PhotoContainer.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 24/06/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoContainer : UIView
{
    NSTimer* uploading_timer;
}
@property (nonatomic, strong) IBOutlet UIImageView* photoImage;
@property (nonatomic, strong) IBOutlet UIImageView* videoIcon;
@property (nonatomic, strong) IBOutlet UIProgressView* uploadProgress;

- (void) loadContainer;
- (void) uploadPicture;
- (void) stopProgress;

@end
