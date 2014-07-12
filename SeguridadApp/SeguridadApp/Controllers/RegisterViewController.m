//
//  RegisterViewController.m
//  SeguridadApp
//
//  Created by juan felippo on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "RegisterViewController.h"
#import "MBProgressHUD.h"
#import "MFSideMenu.h"
#import "SideMenuViewController.h"

@interface RegisterViewController ()
{
    UITextField* currentTextfield;
    CGRect originalContainerFrame;
}
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
}

- (void) viewDidAppear:(BOOL)animated
{
    [self setupKeyboardNotifications];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [self removeKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark -
#pragma mark private methods

- (void) setupInterface
{
    self.title = NSLocalizedString(@"Registrarse", @"Registrarse");
    
    [emailField setPlaceholder:NSLocalizedString(@"Email", @"Email")];
    [emailField setKeyboardType:UIKeyboardTypeEmailAddress];
    [emailField setReturnKeyType:UIReturnKeyNext];
    
    [user_name setPlaceholder:NSLocalizedString(@"Name",@"Name")];
    [user_name setReturnKeyType:UIReturnKeyNext];
    
    [user_firstname setPlaceholder:NSLocalizedString(@"First name",@"First name")];
    [user_firstname setReturnKeyType:UIReturnKeyNext];
    
    [passwordField setPlaceholder:NSLocalizedString(@"Password", @"Password")];
    [passwordField setReturnKeyType:UIReturnKeyNext];
    [passwordField setSecureTextEntry:YES];
    [passwordConfirmField setSecureTextEntry:YES];
    [passwordConfirmField setPlaceholder:NSLocalizedString(@"Confirm password", @"Confirm password")];
    [passwordConfirmField setReturnKeyType:UIReturnKeyDone];
    
    
    [registerButton setTitle:NSLocalizedString(@"Register",@"Register") forState:UIControlStateNormal];
    [termsButton setTitle:NSLocalizedString(@"Terms and Use Conditions", @"Terms and Use Conditions") forState:UIControlStateNormal];

    CGFloat max_y_content_scroll = registerButton.frame.origin.y + registerButton.frame.size.height + 10;
    [container_scroll setContentSize:CGSizeMake(container_scroll.frame.size.width, max_y_content_scroll)];
    originalContainerFrame = container_scroll.frame;
    
    [photoImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer* pictureTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageAction:)];
    [pictureTapRecognizer setNumberOfTapsRequired:1];
    [pictureTapRecognizer setNumberOfTouchesRequired:1];
    [photoImageView addGestureRecognizer:pictureTapRecognizer];
    
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Atrás" style:UIBarButtonItemStyleBordered target:self action:@selector(popView)];
    self.navigationItem.leftBarButtonItem = customBarItem;
}



- (void)popView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) removeKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void) setupKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark -
#pragma mark Keyboards methods

//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{
    
    // get keyboard size and loctaion
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
	// get a rect for the textView frame
	CGRect containerFrame = container_scroll.frame;
    containerFrame.size.height = self.view.bounds.size.height - keyboardBounds.size.height;
    
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
	
	// set views with new info
	container_scroll.frame = containerFrame;
	
	// commit animations
	[UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
	
	// get a rect for the textView frame
	CGRect containerFrame = container_scroll.frame;
    containerFrame.size.height = originalContainerFrame.size.height;
    
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
	// set views with new info
	container_scroll.frame = containerFrame;
	// commit animations
	[UIView commitAnimations];
    
}

#pragma mark -
#pragma mark Actions methods

- (IBAction)registerButtonAction:(id)sender
{
    if (emailField.text.length == 0 || user_name.text.length == 0 || user_firstname.text.length == 0 ||
        passwordField.text.length == 0 || passwordConfirmField.text.length == 0) {
        
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"You must complete all fields.",@"You must complete all fields.") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        
        return;
    }
    
    if (![AppHelper NSStringIsValidEmail:emailField.text]){
        
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"You should enter a valid email address.",@"You should enter a valid email address.") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        return;
    }
    
    if (![passwordField.text isEqualToString:passwordConfirmField.text]) {
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Your password fields doesn't match.","Your password fields doesn't match.") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        return;
    }
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading...", @"Loading...");
    
    NSDictionary* params = @{@"email": emailField.text,
                             @"nombre": user_name.text,
                             @"apellido": user_firstname.text,
                             @"password": passwordField.text};
    [NetworkManager runSignupRequestWithParams:params completition:^(NSDictionary *data, NSError *error, NSString* error_message) {
        
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        if (error) {
            [[[UIAlertView alloc] initWithTitle:nil message:error_message delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        }else{
            
            NSString* response = [data objectForKey:@"res"];
            if ([response isEqualToString:SIGN_UP_OK]) {
                [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Se ha registrado correctamente, revise su casilla de correo electronico para confirmar su email. Una vez confirmado, usted puede realizar el login correctamente.","Se ha registrado correctamente, revise su casilla de correo electronico para confirmar su email. Una vez confirmado, usted puede realizar el login correctamente.") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
                
                if (self.originController) {
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
                }
            }
        }
    }];
}

- (IBAction)termsButtonAction:(id)sender
{
    [self performSegueWithIdentifier:@"termsofuseSegue" sender:nil];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField{
    currentTextfield = textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ( textField == emailField ) {
        [user_name becomeFirstResponder];
    }else if (textField == user_name ) {
        [user_firstname becomeFirstResponder];
    }else if (textField == user_firstname ) {
        [passwordField becomeFirstResponder];
    }else if (textField == passwordField ) {
        [passwordConfirmField becomeFirstResponder];
    }else if (textField == passwordConfirmField ) {
        [passwordConfirmField resignFirstResponder];
    }
    return YES;
}

- (IBAction)addImageAction:(id)sender
{
    [self dismissImputController];
    
    UIActionSheet* pictureActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                    delegate:self
                                                           cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
                                                      destructiveButtonTitle:nil
                                                           otherButtonTitles:NSLocalizedString(@"Camera", @"Camera"),NSLocalizedString(@"Select a Picture", @"Select a Picture"), nil];
    [pictureActionSheet showInView:self.view];
}

- (void) dismissImputController
{
    [currentTextfield resignFirstResponder];
}

#pragma mark -
#pragma mark UIActionSheetDelegate implementation

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:NSLocalizedString(@"Camera", @"Camera")])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
    }else if  ([buttonTitle isEqualToString:NSLocalizedString(@"Select a Picture", @"Select a Picture")])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [photoImageView setClipsToBounds:YES];
    [photoImageView.layer setCornerRadius:(float)5.0];
    [photoImageView setImage:chosenImage];
    
    photoImageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    photoImageView.layer.borderWidth = 0.5f;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
