//
//  SignInViewController.m
//  SeguridadApp
//
//  Created by juan felippo on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "SignInViewController.h"
#import "MFSideMenu.h"
#import "MBProgressHUD.h"
#import "SideMenuViewController.h"

#import "LoginEmailViewController.h"
#import "RegisterViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

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
    [noAccountButton setTitle:NSLocalizedString(@"i have no account", @"i have no account") forState:UIControlStateNormal];
    [loginNormalButton setTitle:NSLocalizedString(@"log in with email", @"log in with email") forState:UIControlStateNormal];
    
    // In your viewDidLoad method:
    loginFacebook.readPermissions = @[@"public_profile", @"email"];
    loginFacebook.delegate = self;
}

#pragma mark -
#pragma mark Actions methods

- (IBAction) loginNormalButton:(id)sender
{
    [self performSegueWithIdentifier:@"loginEmailSegue" sender:nil];
}

- (IBAction) noAccountButton:(id)sender
{
    [self performSegueWithIdentifier:@"registerSegue" sender:nil];
}

#pragma mark -
#pragma mark Segue methods

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"loginEmailSegue"]) {
        LoginEmailViewController* vc = [segue destinationViewController];
        vc.originController = self.originController;
    }else if ([segue.identifier isEqualToString:@"registerSegue"]) {
        RegisterViewController* vc = [segue destinationViewController];
        vc.originController = self.originController;
    }
}

#pragma mark - 
#pragma mark FBLoginViewDelegate methods
// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    
    NSLog(@"user: %@",user);
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = NSLocalizedString(@"Ingresando...", @"Ingresando...");
    
    //Login With Facebook
    NSDictionary* params = @{@"email": [user objectForKey:@"email"], @"password": [user objectForKey:@"id"]};
    [NetworkManager runLoginRequestWithParams:params completition:^(NSDictionary *data, NSError *error, NSString* error_message) {
        
        NSLog(@"%@",params);
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        
        
        //if ([data objectForKey:@"err"]) {
        if (error) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.labelText = NSLocalizedString(@"Registrando...", @"Registrando...");
            
            NSDictionary* paramsRegister = @{@"email": [user objectForKey:@"email"],
                                     @"nombre": [user objectForKey:@"first_name"],
                                     @"apellido": [user objectForKey:@"last_name"],
                                     @"password": [user objectForKey:@"id"]};
            NSLog(@"%@",paramsRegister);
            
            //    Register
            [NetworkManager runSignupRequestWithParams:paramsRegister completition:^(NSDictionary *data, NSError *error, NSString* error_message) {
                
                [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
                
                if (error) {
                    [[[UIAlertView alloc] initWithTitle:nil message:error_message delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
                }else{
                    
                    NSString* response = [data objectForKey:@"res"];
                    if ([response isEqualToString:SIGN_UP_OK]) {
                        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Registration successfully.","Registration successfully.") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
                        
                        // go to main scren or do something
                        if (self.originController) {
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
        }else{
            
            // guardamos el usuario y password
            //[UserHelper saveUser:[user objectForKey:@"email"] password:[user objectForKey:@"id"]];
            [UserHelper saveUser:[user objectForKey:@"email"] password:[user objectForKey:@"id"] first_name:[user objectForKey:@"first_name"] last_name:[user objectForKey:@"last_name"]];
            
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


@end
