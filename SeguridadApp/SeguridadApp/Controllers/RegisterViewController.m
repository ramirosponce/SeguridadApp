//
//  RegisterViewController.m
//  SeguridadApp
//
//  Created by juan felippo on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupInterface];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark private methods

- (void) setupInterface
{
    [emailField setPlaceholder:NSLocalizedString(@"Email", @"Email")];
    [emailField setKeyboardType:UIKeyboardTypeEmailAddress];
    [emailField setReturnKeyType:UIReturnKeyNext];
    [userNameField setPlaceholder:NSLocalizedString(@"User Name",@"User Name")];
    [userNameField setReturnKeyType:UIReturnKeyNext];
    [passwordField setPlaceholder:NSLocalizedString(@"Password", @"Password")];
    [passwordField setReturnKeyType:UIReturnKeyNext];
    [passwordField setSecureTextEntry:YES];
    [passwordConfirmField setSecureTextEntry:YES];
    [passwordConfirmField setPlaceholder:NSLocalizedString(@"Confirm password", @"Confirm password")];
    [passwordConfirmField setReturnKeyType:UIReturnKeyDone];
    [registerButton setText:NSLocalizedString(@"Register",@"Register")];
    [termsButton setText:NSLocalizedString(@"Terms and Use Conditions", @"Terms and Use Conditions")];
    
    [registerButton setUserInteractionEnabled:YES];
    UITapGestureRecognizer* registerButtonGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapViewWithGesture:)];
    [registerButtonGesture setNumberOfTapsRequired:1];
    [registerButton addGestureRecognizer:registerButtonGesture];
    
    [termsButton setUserInteractionEnabled:YES];
    UITapGestureRecognizer* termsButtonGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapViewWithGesturePush:)];
    [termsButtonGesture setNumberOfTapsRequired:1];
    [termsButton addGestureRecognizer:termsButtonGesture];
    
}
#pragma mark -
#pragma mark Actions methods
- (void) didTapViewWithGesture:(UITapGestureRecognizer*) tapGesture
{
    [[[UIAlertView alloc] initWithTitle:nil message:@"register button action" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}
- (void) didTapViewWithGesturePush:(UITapGestureRecognizer*) tapGesture
{
    [self performSegueWithIdentifier:@"termsofuseSegue" sender:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ( textField == emailField ) { [userNameField becomeFirstResponder]; }
  else if (textField == userNameField ) { [passwordField becomeFirstResponder]; }
    else if (textField == passwordField ) { [passwordConfirmField becomeFirstResponder]; }
   else if (textField == passwordConfirmField ) { [passwordConfirmField resignFirstResponder]; }
    return YES;
}
@end
