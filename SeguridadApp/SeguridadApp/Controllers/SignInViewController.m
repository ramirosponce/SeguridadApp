//
//  SignInViewController.m
//  SeguridadApp
//
//  Created by juan felippo on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "SignInViewController.h"
#import "MFSideMenu.h"

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
