//
//  LoginEmailViewController.h
//  SeguridadApp
//
//  Created by juan felippo on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginEmailViewController : UIViewController <UITextFieldDelegate>
{
    __weak IBOutlet UITextField* emailField;
    __weak IBOutlet UITextField* passwordField;
    __weak IBOutlet UILabel* loginButton;
    __weak IBOutlet UILabel* noaccountButton;
}

@end
