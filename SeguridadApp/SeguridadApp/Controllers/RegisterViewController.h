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
    __weak IBOutlet UITextField* userNameField;
    __weak IBOutlet UITextField* passwordField;
    __weak IBOutlet UITextField* passwordConfirmField;
    __weak IBOutlet UILabel* registerButton;
    __weak IBOutlet UILabel* termsButton;
    
    __weak IBOutlet UIImageView* photoImageView;

}

@end
