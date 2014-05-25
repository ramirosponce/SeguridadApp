//
//  LoginEmailViewController.m
//  SeguridadApp
//
//  Created by juan felippo on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "LoginEmailViewController.h"
#import "MBProgressHUD.h"

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
    
    // chequeamos si el usuario ya se logueo, ponemos el ultimo usuario logueado en la aplicacion
    NSString* email_logged = [UserHelper getUserMailSaved];
    emailField.text = @"";
    if (email_logged) {
        emailField.text = email_logged;
    }
    
}

#pragma mark -
#pragma mark Actions methods

- (IBAction)loginButtonAction:(id)sender
{
    [activeTextField resignFirstResponder];
    
    if (emailField.text.length == 0 || passwordField.text.length == 0) {
        
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"You must complete all fields.",@"You must complete all fields.") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        
        return;
    }
    
    if (![AppHelper NSStringIsValidEmail:emailField.text]){
        
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"You should enter a valid email address.",@"You should enter a valid email address.") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading...", @"Loading...");
    
    NSDictionary* params = @{@"email": emailField.text, @"password": passwordField.text};
    [NetworkManager runLoginRequestWithParams:params completition:^(NSDictionary *data, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        if (!data) {
            [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Something is wrong, please try again later.","Something is wrong, please try again later.") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        }else{
            
            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
            // guardamos el usuario y password
            [UserHelper saveUser:emailField.text password:passwordField.text];
            
            // guardamos el token
            NSString* token = [data objectForKey:@"token"];
            if (token) {
                [UserHelper saveToken:token];
            }
            
            // do something or go to main screen
        }
    }];
    
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
