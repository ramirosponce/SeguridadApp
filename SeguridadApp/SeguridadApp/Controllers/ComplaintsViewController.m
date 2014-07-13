//
//  ComplaintsViewController.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 04/06/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "ComplaintsViewController.h"
#import "DetailViewController.h"
#import "MBProgressHUD.h"
#import "ComplaintCell.h"
#import "Complaint.h"
#import "MFSideMenu.h"
#import "ComplaintType.h"

@interface ComplaintsViewController ()
{
    NSMutableArray* data;
    Complaint* currentComplaintSelected;
}
@end

@implementation ComplaintsViewController

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
}

- (NSString*) getFilterDateKey
{
    
    NSString* date_filter;
    switch ([GlobalManager sharedManager].datefilterType) {
        case kDateFilterToday:
            date_filter = @"today";
            break;
        case kDateFilterWeek:
            date_filter = @"lastWeek";
            break;
        case kDateFilterMonth:
            date_filter = @"lastMonth";
            break;
        case kDateFilterAll:
            date_filter = nil;
            break;
    }
    return date_filter;
}

- (void) viewDidAppear:(BOOL)animated
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading...", @"Loading...");
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    NSString* date_filter_selected = [self getFilterDateKey];
    
    // date filter
    if (date_filter_selected) {
        [params setObject:[NSNumber numberWithInt:1] forKey:date_filter_selected];
    }
    
    // limit filter
    [params setObject:[NSNumber numberWithInt:MAX_COMPLAINT_COUNT] forKey:@"limit"];
    
    // Input search
    //if (![[GlobalManager sharedManager].category_selected isEqualToString:NSLocalizedString(@"All", @"All")]) {
    //    [params setObject:[GlobalManager sharedManager].category_selected forKey:@"inputSearch"];
    //}
    
    if (![GlobalManager sharedManager].categoryAllSelected) {
        NSLog(@"Categories: %@",[GlobalManager sharedManager].category_filters);
        
        NSMutableArray* objects = [NSMutableArray arrayWithCapacity:0];
        for (ComplaintType* category in [GlobalManager sharedManager].category_filters) {
            [objects addObject:category.name];
        }
        [params setObject:objects forKey:@"inputSearch"];
    }
    
    
    [NetworkManager runSearchRequestWithParams:params completition:^(NSArray *map_complaints, NSError *error) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        data = [[NSMutableArray alloc] initWithArray:map_complaints];
        [complaintTableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark private methods

- (void) setupInterface
{
    self.title = NSLocalizedString(@"Denuncias", @"Denuncias");
    
    [complaintTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //[complaintTableView setContentInset:UIEdgeInsetsMake(0,0,70,0)];
    
    UIBarButtonItem* options = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    self.navigationItem.leftBarButtonItem = options;
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

#pragma mark -
#pragma mark UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"ComplaintCell";
    
    ComplaintCell* cell = (ComplaintCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (ComplaintCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    Complaint* complaint = [data objectAtIndex:indexPath.row];
    [cell populateCell:complaint];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentComplaintSelected = [data objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"detailSegue" sender:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Segue methods

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        
        DetailViewController* complaintVC = [segue destinationViewController];
        complaintVC.complaint = currentComplaintSelected;
    }
}

@end
