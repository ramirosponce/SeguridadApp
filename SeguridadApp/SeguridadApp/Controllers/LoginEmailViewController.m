//
//  LoginEmailViewController.m
//  SeguridadApp
//
//  Created by juan felippo on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "LoginEmailViewController.h"
#import "MBProgressHUD.h"
#import "MFSideMenu.h"
#import "SideMenuViewController.h"

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
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Atrás" style:UIBarButtonItemStyleBordered target:self action:@selector(popView)];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
}

- (void)popView
{
    [self.navigationController popViewControllerAnimated:YES];
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
    [NetworkManager runLoginRequestWithParams:params completition:^(NSDictionary *data, NSError *error, NSString* error_message) {
        
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        if (error) {
            [[[UIAlertView alloc] initWithTitle:nil message:error_message delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        }else{
            
            NSString* user_email = nil;
            NSString* user_firstname = nil;
            NSString* user_lastname = nil;
            
            if ([[data objectForKey:@"usr"] objectForKey:@"email"]) {
                user_email = [[data objectForKey:@"usr"] objectForKey:@"email"];
            }else{
                user_email = @"";
            }
            
            if ([[data objectForKey:@"usr"] objectForKey:@"nombre"]) {
                user_firstname = [[data objectForKey:@"usr"] objectForKey:@"nombre"];
            }else{
                user_firstname = @"";
            }
            
            if ([[data objectForKey:@"usr"] objectForKey:@"apellido"]) {
                user_lastname = [[data objectForKey:@"usr"] objectForKey:@"apellido"];
            }else{
                user_lastname = @"";
            }
            
            
            // guardamos el usuario y password
            //[UserHelper saveUser:emailField.text password:passwordField.text];
            [UserHelper saveUser:user_email password:passwordField.text first_name:user_firstname last_name:user_lastname];
            
            // guardamos el token
            NSString* token = [data objectForKey:@"token"];
            if (token) {
                [UserHelper saveToken:token];
            }
            
            if (self.originController) {
                
                UINavigationController *navigationController = (UINavigationController*)self.parentViewController;
                MFSideMenuContainerViewController *container = (MFSideMenuContainerViewController*)[navigationController parentViewController];
                SideMenuViewController* sideMenu = (SideMenuViewController*)container.leftMenuViewController;
                [sideMenu changeUserStatus];
                
                
                if ([self.originController respondsToSelector:@selector(loginComplete)]) {
                    [self.originController performSelector:@selector(loginComplete)];
                }
                [self.navigationController popToViewController:self.originController animated:YES];
                
            }else{
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                UINavigationController *navigationController = (UINavigationController*)self.parentViewController;
                MFSideMenuContainerViewController *container = (MFSideMenuContainerViewController*)[navigationController parentViewController];
                UINavigationController *centerViewController =
                [storyboard instantiateViewControllerWithIdentifier:@"CenterViewController"];
                [container setCenterViewController:centerViewController];
                
                SideMenuViewController* sideMenu = (SideMenuViewController*)container.leftMenuViewController;
                [sideMenu changeUserStatus];
            }
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
