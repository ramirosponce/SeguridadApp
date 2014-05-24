//
//  LoaderViewController.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 05/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "LoaderViewController.h"

#import "MFSideMenu.h"
#import "SideMenuViewController.h"
#import "MainScreenViewController.h"
#import "MBProgressHUD.h"

@interface LoaderViewController ()

@end

@implementation LoaderViewController

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
    
    if (IS_IPHONE_5) {
        [loader_background setImage:[UIImage imageNamed:@"Default-568h@2x.png"]];
    }else{
        [loader_background setImage:[UIImage imageNamed:@"Default.png"]];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading...", @"Loading...");
    
    [NetworkManager runComplaintTypesRequest:^(NSArray *types, NSError *error) {
        if (!error) {
            
            [[GlobalManager sharedManager] saveComplaintTypes:types];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [self performSelector:@selector(showMainScreen) withObject:nil afterDelay:0.5];
        }else{
#warning MANEJAR ERROR DE CARGA DE TIPOS DE DENUNCIAS
            NSLog(@"%@",error.description);
        }
    }];
}

- (void)showMainScreen
{
    [self performSegueWithIdentifier:@"ShowMainScreen" sender:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowMainScreen"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        MFSideMenuContainerViewController *container = [segue destinationViewController];
        UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"CenterViewController"];
        UIViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"SideMenuController"];
        
        [container setLeftMenuViewController:leftSideMenuViewController];
        [container setCenterViewController:navigationController];
        
        [container setMenuSlideAnimationEnabled:YES];
        [container setMenuSlideAnimationFactor:3.0f];
    }
}

@end
