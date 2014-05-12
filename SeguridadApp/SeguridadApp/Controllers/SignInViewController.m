//
//  SignInViewController.m
//  SeguridadApp
//
//  Created by juan felippo on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "SignInViewController.h"

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
    [signinNormalButton setText:NSLocalizedString(@"log in with email", @"log in with email")];
    [noaccountButton setText:NSLocalizedString(@"i have no account", @"i have no account")];
    
    [signinNormalButton setUserInteractionEnabled:YES];
    UITapGestureRecognizer* signinNormalButtonGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapViewWithGesture:)];
    [signinNormalButtonGesture setNumberOfTapsRequired:1];
    [signinNormalButton addGestureRecognizer:signinNormalButtonGesture];
    
    [noaccountButton setUserInteractionEnabled:YES];
    UITapGestureRecognizer* noaccountButtonGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapViewWithGesturePush:)];
    [noaccountButtonGesture setNumberOfTapsRequired:1];
    [noaccountButton addGestureRecognizer:noaccountButtonGesture];
}
#pragma mark -
#pragma mark Actions methods
- (void) didTapViewWithGesture:(UITapGestureRecognizer*) tapGesture
{
    [self performSegueWithIdentifier:@"loginEmailSegue" sender:nil];
}
- (void) didTapViewWithGesturePush:(UITapGestureRecognizer*) tapGesture
{
    [self performSegueWithIdentifier:@"registerSegue" sender:nil];
}
@end
