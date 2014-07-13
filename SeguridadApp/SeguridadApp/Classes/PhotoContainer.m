//
//  PhotoContainer.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 24/06/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "PhotoContainer.h"

@interface PhotoContainer ()
{
    CGFloat currentProgress;
}
@end

@implementation PhotoContainer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) loadContainer
{
    [self.uploadProgress setTransform:CGAffineTransformMakeScale(1.0, 3.0)];
    [self.uploadProgress setProgress:0.0];
    self.uploadProgress.hidden = YES;
    self.videoIcon.hidden = YES;
}

- (void) uploadPicture
{
    self.uploadProgress.hidden = NO;
    currentProgress = 0.1;
    [self runUploading];
}

- (void) runUploading
{
    uploading_timer = [NSTimer scheduledTimerWithTimeInterval:0.75 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}

- (void) updateProgress
{
    if (currentProgress < 0.9) {
        [self.uploadProgress setProgress:currentProgress];
        currentProgress += 0.1;
    }else{
        [uploading_timer invalidate];
        uploading_timer = nil;
    }
}

- (void) stopProgress
{
    [self.uploadProgress setProgress:0.0];
    self.uploadProgress.hidden = YES;
    [uploading_timer invalidate];
    uploading_timer = nil;
}

@end
