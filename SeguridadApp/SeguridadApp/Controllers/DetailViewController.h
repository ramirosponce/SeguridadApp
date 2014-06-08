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

@class Complaint;

@protocol DetailDelegate <NSObject>

@optional

- (void) photoTouched:(int)idx;
- (void) affectedAction:(id)sender;
- (void) isTrueAction:(id)sender;
- (void) isNotTrueAction:(id)sender;

@end

@interface DetailViewController : SLParallaxController <UIActionSheetDelegate, HPGrowingTextViewDelegate, UIAlertViewDelegate, DetailDelegate>
{
    UIView *containerView;
    HPGrowingTextView *textView;
}
@property (nonatomic, strong) Complaint* complaint;

@end
