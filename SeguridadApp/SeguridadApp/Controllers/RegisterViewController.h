//
//  RegisterViewController.h
//  SeguridadApp
//
//  Created by juan felippo on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    __weak IBOutlet UITextField* emailField;
    
    __weak IBOutlet UITextField* user_name;
    __weak IBOutlet UITextField* user_firstname;
    
    __weak IBOutlet UITextField* passwordField;
    __weak IBOutlet UITextField* passwordConfirmField;
    
    __weak IBOutlet UIButton* registerButton;
    __weak IBOutlet UIButton* termsButton;
    
    __weak IBOutlet UIScrollView* container_scroll;
    
    __weak IBOutlet UIImageView* photoImageView;

}

@property (nonatomic, assign) UIViewController* originController;

- (IBAction)registerButtonAction:(id)sender;
- (IBAction)termsButtonAction:(id)sender;

@end
