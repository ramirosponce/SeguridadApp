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

@interface DetailViewController : SLParallaxController <UIActionSheetDelegate, HPGrowingTextViewDelegate>
{
    UIView *containerView;
    HPGrowingTextView *textView;
}
@property (nonatomic, strong) Complaint* complaint;

@end
