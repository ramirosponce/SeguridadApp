//
//  SideMenuViewController.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 05/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "MenuCell.h"
#import "FiltersViewController.h"
#import "SettingsViewController.h"

@interface SideMenuViewController ()
{
    NSArray* data;
    int selectedIndex;
}
@end

@implementation SideMenuViewController

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
             @{@"title": NSLocalizedString(@"Map", @"Map"),@"icon_name": @"pin_icon.png"},
             @{@"title": NSLocalizedString(@"Complaints", @"Complaints"),@"icon_name": @"eye_icon.png",@"hasNew":[NSNumber numberWithBool:YES],@"newCount":[NSNumber numberWithInt:12]},
             @{@"title": NSLocalizedString(@"Filters", @"Filters"),@"icon_name": @"switches_icon.png"},
             @{@"title": NSLocalizedString(@"Another thing?", @"Another thing?"),@"icon_name": @"filters_icon.png"},
             @{@"title": NSLocalizedString(@"Settings", @"Settings"),@"icon_name": @"tire_icon.png"},
             ];
    
    [self setupInterface];
    [self setupProfile];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark private methods

- (void) setupInterface
{
    [menuTableView setBackgroundColor:[UIColor clearColor]];
    [menuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [profile_view setUserInteractionEnabled:YES];
    UITapGestureRecognizer* profileViewDateGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapViewWithGesture:)];
    [profileViewDateGesture setNumberOfTapsRequired:1];
    [profile_view addGestureRecognizer:profileViewDateGesture];
    
}

- (void) setupProfile
{
    [avatar_imageView setClipsToBounds:YES];
    [avatar_imageView.layer setCornerRadius:(float)(avatar_imageView.frame.size.width/2)];
    [avatar_imageView setImage:[UIImage imageNamed:@"avatar.jpg"]];
    
    //avatar_imageView.layer.borderColor = [[UIColor colorWithRed:0.83 green:0.90 blue:96.0 alpha:1.0] CGColor];
    avatar_imageView.layer.borderColor = [UIColorFromRGB(0x067AB5) CGColor];
    avatar_imageView.layer.borderWidth = 3.0f;
    
    [profile_name setText:@"Ramiro Ponce"];
    [profile_legend setText:NSLocalizedString(@"View Profile & History", @"View Profile & History")];
    
    // map index by default
    selectedIndex = 0;
}

#pragma mark -
#pragma mark Actions methods

- (void) didTapViewWithGesture:(UITapGestureRecognizer*) tapGesture
{
    selectedIndex = -1;
    [menuTableView reloadData];
    
    MFSideMenuContainerViewController *container = (MFSideMenuContainerViewController*)[self parentViewController];
    
    if (container.menuState == MFSideMenuStateLeftMenuOpen) {
        [container setMenuState:MFSideMenuStateClosed completion:nil];
    }else{
        [container setMenuState:MFSideMenuStateLeftMenuOpen completion:nil];
    }
}

#pragma mark -
#pragma mark UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"MenuCell";
    
    MenuCell* cell = (MenuCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (MenuCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.selectedBackgroundView.backgroundColor=[UIColor redColor];
    
    BOOL isSelected = NO;
    if (indexPath.row == selectedIndex) {
        isSelected = YES;
    }
    
    NSDictionary* dic = [data objectAtIndex:indexPath.row];
    BOOL hasNew = NO;
    int newCount = 0;
    if ([dic objectForKey:@"hasNew"]) {
        hasNew = [[dic objectForKey:@"hasNew"] boolValue];
        hasNew = YES;
        newCount = [[dic objectForKey:@"newCount"] intValue];
    }
    
    [cell populateCell:[data objectAtIndex:indexPath.row] isSelected:isSelected badge:hasNew badgeCount:newCount badgeColor:[UIColor redColor]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath.row;
    [menuTableView reloadData];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MFSideMenuContainerViewController *container = (MFSideMenuContainerViewController*)[self parentViewController];
    
    switch (indexPath.row) {
        case 0:{
            UINavigationController *navigationController =
            [storyboard instantiateViewControllerWithIdentifier:@"CenterViewController"];
            [container setCenterViewController:navigationController];
        }
            
            break;
        case 2:{
            FiltersViewController *filtersController =
            [storyboard instantiateViewControllerWithIdentifier:@"FiltersViewController"];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:filtersController];
            
            [navigationController.navigationBar setTranslucent:NO];
            
            //[[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x067AB5)];
            //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
            
            //[[UINavigationBar appearance]
            // setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,
            //                         [UIFont systemFontOfSize:17.0], NSFontAttributeName,
            //                         nil]];
            
            filtersController.fromMenu = YES;
            [container setCenterViewController:navigationController];
        }
            
            break;
        case 4:{
            SettingsViewController *settingsController =
            [storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:settingsController];
            [navigationController.navigationBar setTranslucent:NO];
             [container setCenterViewController:navigationController];
        }
            
            break;
        default:
            break;
    }
    
    if (container.menuState == MFSideMenuStateLeftMenuOpen) {
        [container setMenuState:MFSideMenuStateClosed completion:nil];
    }else{
        [container setMenuState:MFSideMenuStateLeftMenuOpen completion:nil];
    }
}

@end
