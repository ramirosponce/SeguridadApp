//
//  DetailViewController.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLParallaxController.h"
#import "HPGrowingTextView.h"
#import <MediaPlayer/MediaPlayer.h>

@class Complaint;

@protocol DetailDelegate <NSObject>

@optional

- (void) photoTouched:(int)idx;
- (void) videoTouched:(NSString*)videoURLString;

- (void) affectedAction:(id)sender;
- (void) isTrueAction:(id)sender;
- (void) isNotTrueAction:(id)sender;

@end

@interface DetailViewController : SLParallaxController <UIActionSheetDelegate, HPGrowingTextViewDelegate, UIAlertViewDelegate, DetailDelegate>
{
    UIView *containerView;
    HPGrowingTextView *textView;
    MPMoviePlayerController *moviePlayer;
}
@property (nonatomic, strong) Complaint* complaint;

@end
