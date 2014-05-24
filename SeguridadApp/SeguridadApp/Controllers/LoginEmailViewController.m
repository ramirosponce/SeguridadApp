//
//  LoginEmailViewController.m
//  SeguridadApp
//
//  Created by juan felippo on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "LoginEmailViewController.h"

@interface LoginEmailViewController ()
{
    UITextField * activeTextField;
}
@end

@implementation LoginEmailViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark -
#pragma mark private methods

- (void) setupInterface
{
    self.title = NSLocalizedString(@"Iniciar Sesion", @"Iniciar Sesion");
    
    [emailField setPlaceholder:NSLocalizedString(@"Email", @"Email")];
    [emailField setKeyboardType:UIKeyboardTypeEmailAddress];
    [emailField setReturnKeyType:UIReturnKeyNext];
    [passwordField setPlaceholder:NSLocalizedString(@"Password", @"Password")];
    [passwordField setSecureTextEntry:YES];
    [passwordField setReturnKeyType:UIReturnKeyDone];
    
    emailField.delegate = self;
    passwordField.delegate = self;
    
    [loginButton setTitle:NSLocalizedString(@"Sign In", @"Sign In") forState:UIControlStateNormal];
    [noAccountButton setTitle:NSLocalizedString(@"i have no account", @"i have no account") forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark Actions methods

- (IBAction)loginButtonAction:(id)sender
{
    [activeTextField resignFirstResponder];
    [[[UIAlertView alloc] initWithTitle:nil message:@"login button action" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (IBAction)noAccountButtonAction:(id)sender
{
    [activeTextField resignFirstResponder];
    [self performSegueWithIdentifier:@"registerSegue" sender:nil];
    
}

#pragma mark -
#pragma mark UITextfieldDelegate methods

- (void) textFieldDidBeginEditing:(UITextField *)textField{
    activeTextField = textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ( textField == emailField ) {
        [passwordField becomeFirstResponder];
    }else if (textField == passwordField ) {
        [passwordField resignFirstResponder];
    }
    return YES;
}

@end
