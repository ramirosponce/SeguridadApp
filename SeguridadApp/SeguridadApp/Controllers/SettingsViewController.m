//
//  SettingsViewController.m
//  SeguridadApp
//
//  Created by juan felippo on 09/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsCell.h"
#import "MFSideMenu.h"
#import "TermsOfUseViewController.h"

@interface SettingsViewController ()
{
    NSArray* data;
}
@end

@implementation SettingsViewController

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
    data = @[
             @{@"title": NSLocalizedString(@"Help us to improve", @"Help us to improve")},
             @{@"title": NSLocalizedString(@"Terms and Use Conditions", @"Terms and Use Conditions")},
             @{@"title": NSLocalizedString(@"About", @"About")},
             @{@"title": NSLocalizedString(@"Share", @"Share")},
             @{@"title": NSLocalizedString(@"Maps Information", @"Maps Information")},
             @{@"title": NSLocalizedString(@"Sign In", @"Sign In")},
             ];
    [settingsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.title = NSLocalizedString(@"Settings", @"Settings");
    UIBarButtonItem* options = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    self.navigationItem.leftBarButtonItem = options;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"SettingsCell";
    
    SettingsCell* cell = (SettingsCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (SettingsCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell populateCell:[[data objectAtIndex:indexPath.row] objectForKey:@"title"]];
    
    return cell;
}
- (void) showMenu
{
    // open the left side menu
    UINavigationController *navigationController = (UINavigationController*)self.parentViewController;
    MFSideMenuContainerViewController *container = (MFSideMenuContainerViewController*)[navigationController parentViewController];
    
    if (container.menuState == MFSideMenuStateLeftMenuOpen) {
        [container setMenuState:MFSideMenuStateClosed completion:nil];
    }else{
        [container setMenuState:MFSideMenuStateLeftMenuOpen completion:nil];
    }
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"suggestionSegue" sender:nil];
            break;
        case 1:
            [self performSegueWithIdentifier:@"termsofseSegue" sender:nil];
            break;
        case 2:
            [self performSegueWithIdentifier:@"aboutSegue" sender:nil];
            break;
        case 3:{
            NSString *shareString = @"Estoy usando la aplicacion de seguridad para hacer denuncias en mi iphone.";
            //UIImage *shareImage = [UIImage imageNamed:@"filter_arrow.png"];
            NSURL *shareUrl = [NSURL URLWithString:@"http://www.google.com"];
            
            NSArray *activityItems = [NSArray arrayWithObjects:shareString, shareUrl, nil];
            UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
            activityViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            
            [self presentViewController:activityViewController animated:YES completion:nil];
            
            }
            break;
        case 4:
            [self performSegueWithIdentifier:@"mapInformationSegue" sender:nil];
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
