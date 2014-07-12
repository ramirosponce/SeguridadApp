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
#import "SignInViewController.h"

@interface SettingsViewController ()
{
    NSMutableArray* data;
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
    
    [self setupInterface];
    
    data = [[NSMutableArray alloc] initWithCapacity:0];
    //[data addObject:@{@"title": NSLocalizedString(@"Help us to improve", @"Help us to improve")}];
    [data addObject:@{@"title": NSLocalizedString(@"Terms and Use Conditions", @"Terms and Use Conditions")}];
    [data addObject:@{@"title": NSLocalizedString(@"About", @"About")}];
    [data addObject:@{@"title": NSLocalizedString(@"Share", @"Share")}];
    //[data addObject:@{@"title": NSLocalizedString(@"Maps Information", @"Maps Information")}];
    
    //Pregunto si existe el Token y sino existe permitimos el Sign In
    if (![UserHelper getUserToken]) {
        [data addObject:@{@"title": NSLocalizedString(@"Sign In", @"Sign In")}];
    }
    
    [settingsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
    self.title = NSLocalizedString(@"Settings", @"Settings");
    UIBarButtonItem* options = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    self.navigationItem.leftBarButtonItem = options;
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
        //case 0:
        //    [self performSegueWithIdentifier:@"suggestionSegue" sender:nil];
        //    break;
        case 0:
            [self performSegueWithIdentifier:@"termsofseSegue" sender:nil];
            break;
        case 1:
            [self performSegueWithIdentifier:@"aboutSegue" sender:nil];
            break;
        case 2:{
            NSString *shareString = @"Estoy usando la aplicacion de Policia Metropolitana AMET para hacer denuncias desde mi iPhone.";
            NSURL *shareUrl = [NSURL URLWithString:@"http://911enlinea.do/app"];
            
            NSArray *activityItems = [NSArray arrayWithObjects:shareString, shareUrl, nil];
            UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
            activityViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            
            [self presentViewController:activityViewController animated:YES completion:nil];
            
            }
            break;
        //case 4:
        //    [self performSegueWithIdentifier:@"mapInformationSegue" sender:nil];
        //    break;
        case 3:
            [self performSegueWithIdentifier:@"signInScreenSegue" sender:nil];
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
