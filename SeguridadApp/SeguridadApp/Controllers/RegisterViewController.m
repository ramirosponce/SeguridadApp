//
//  RegisterViewController.m
//  SeguridadApp
//
//  Created by juan felippo on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
{
    UITextField* currentTextfield;
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
    
    [photoImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer* pictureTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageAction:)];
    [pictureTapRecognizer setNumberOfTapsRequired:1];
    [pictureTapRecognizer setNumberOfTouchesRequired:1];
    [photoImageView addGestureRecognizer:pictureTapRecognizer];
    
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

- (void) textFieldDidBeginEditing:(UITextField *)textField{
    currentTextfield = textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ( textField == emailField ) {
        [userNameField becomeFirstResponder];
    }else if (textField == userNameField ) {
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
