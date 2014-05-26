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
#pragma mark FBLoginViewDelegate methods
// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    
    NSLog(@"user: %@",user);
    /*
     email = "turco082@gmail.com";
     "first_name" = Edgar;
     gender = male;
     id = 288080781353539;
     "last_name" = Glellel;
     link = "https://www.facebook.com/app_scoped_user_id/288080781353539/";
     locale = "es_LA";
     name = "Edgar Glellel";
     timezone = "-3";
     "updated_time" = "2012-10-12T16:51:52+0000";
     verified = 0;
     */
    
    
    
    //MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    //hud.labelText = NSLocalizedString(@"Loading...", @"Loading...");
    
    //Login With Facebook
    NSDictionary* params = @{@"email": [user objectForKey:@"email"], @"password": [user objectForKey:@"id"]};
    [NetworkManager runLoginRequestWithParams:params completition:^(NSDictionary *data, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        if (!data) {
            //[[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Something is wrong, please try again later.","Something is wrong, please try again later.") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
            NSDictionary* paramsRegister = @{@"email": [user objectForKey:@"email"],
                                     @"nombre": [user objectForKey:@"first_name"],
                                     @"apellido": [user objectForKey:@"last_name"],
                                     @"password": [user objectForKey:@"id"]};
            //    Register
            [NetworkManager runSignupRequestWithParams:paramsRegister completition:^(NSDictionary *data, NSError *error) {
                
                //[MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
                
                if (!data) {
                    [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Something is wrong, please try again later.","Something is wrong, please try again later.") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
                }else{
                    
                    NSString* response = [data objectForKey:@"res"];
                    if ([response isEqualToString:SIGN_UP_OK]) {
                        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Registration successfully.","Registration successfully.") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
                        // go to main scren or do something
                    }
                    
                }
            }];
        }else{
            
            //[MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
            // guardamos el usuario y password
            [UserHelper saveUser:[user objectForKey:@"email"] password:[user objectForKey:@"id"]];
            
            // guardamos el token
            NSString* token = [data objectForKey:@"token"];
            if (token) {
                [UserHelper saveToken:token];
            }
            
            // do something or go to main screen
        }
    }];
    
    

    
    
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    
//    UINavigationController *navigationController = (UINavigationController*)self.parentViewController;
//    MFSideMenuContainerViewController *container = (MFSideMenuContainerViewController*)[navigationController parentViewController];
//    
//    UINavigationController *centerViewController =
//    [storyboard instantiateViewControllerWithIdentifier:@"CenterViewController"];
//    [container setCenterViewController:centerViewController];
    
    //self.profilePictureView.profileID = user.id;
    //self.nameLabel.text = user.name;
}


@end
