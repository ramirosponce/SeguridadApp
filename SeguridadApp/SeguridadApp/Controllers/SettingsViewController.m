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
@end
