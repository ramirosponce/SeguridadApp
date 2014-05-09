//
//  SuggestionViewController.h
//  SeguridadApp
//
//  Created by juan felippo on 09/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuggestionViewController : UIViewController <UITextViewDelegate>
{
    __weak IBOutlet UITextView* commentView;
    __weak IBOutlet UILabel* commentPlaceholder;
    __weak IBOutlet UILabel* suggestionText;
    __weak IBOutlet UILabel* suggestLabel;
}

@end
