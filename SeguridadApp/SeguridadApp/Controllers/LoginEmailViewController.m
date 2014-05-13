//
//  LoginEmailViewController.m
//  SeguridadApp
//
//  Created by juan felippo on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "LoginEmailViewController.h"

@interface LoginEmailViewController ()

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
    self.title = NSLocalizedString(@"Iniciar Sesion", @"Iniciar Sesion");
    
    [emailField setPlaceholder:NSLocalizedString(@"Email", @"Email")];
    [emailField setKeyboardType:UIKeyboardTypeEmailAddress];
    [emailField setReturnKeyType:UIReturnKeyNext];
    [passwordField setPlaceholder:NSLocalizedString(@"Password", @"Password")];
    [passwordField setSecureTextEntry:YES];
    [passwordField setReturnKeyType:UIReturnKeyDone];
    [loginButton setText:NSLocalizedString(@"Sign In", @"Sign In")];
    [noaccountButton setText:NSLocalizedString(@"i have no account", @"i have no account")];
    
    [loginButton setUserInteractionEnabled:YES];
    UITapGestureRecognizer* loginButtonGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapViewWithGesture:)];
    [loginButtonGesture setNumberOfTapsRequired:1];
    [loginButton addGestureRecognizer:loginButtonGesture];
    
    [noaccountButton setUserInteractionEnabled:YES];
    UITapGestureRecognizer* noaccountButtonGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapViewWithGesturePush:)];
    [noaccountButtonGesture setNumberOfTapsRequired:1];
    [noaccountButton addGestureRecognizer:noaccountButtonGesture];

}
#pragma mark -
#pragma mark Actions methods
- (void) didTapViewWithGesture:(UITapGestureRecognizer*) tapGesture
{
  [[[UIAlertView alloc] initWithTitle:nil message:@"login button action" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}
- (void) didTapViewWithGesturePush:(UITapGestureRecognizer*) tapGesture
{
    [self performSegueWithIdentifier:@"registerSegue" sender:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ( textField == emailField ) { [passwordField becomeFirstResponder]; }
    else if (textField == passwordField ) { [passwordField resignFirstResponder]; }
    return YES;
}
@end
