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
    
    __weak IBOutlet UIButton* loginButton;
    __weak IBOutlet UIButton* noAccountButton;
    
}

@property (nonatomic, assign) UIViewController* originController;

- (IBAction)loginButtonAction:(id)sender;
- (IBAction)noAccountButtonAction:(id)sender;

@end
