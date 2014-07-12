//
//  MainScreenViewController.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 05/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "MainScreenViewController.h"
#import "DataHelper.h"
#import "ComplaintCell.h"
#import "Complaint.h"
#import "MFSideMenu.h"
#import "FiltersViewController.h"
#import "ComplaintPointAnnotation.h"
#import "DetailViewController.h"
#import "MBProgressHUD.h"
#import "SignInViewController.h"

@interface MainScreenViewController ()
{
    NSMutableArray* data;
    Complaint* currentComplaintSelected;
}
@end

@implementation MainScreenViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    if (![[GlobalManager sharedManager].category_selected isEqualToString:NSLocalizedString(@"All", @"All")]) {
        [params setObject:[GlobalManager sharedManager].category_selected forKey:@"inputSearch"];
    }
    
    [NetworkManager runSearchRequestWithParams:params completition:^(NSArray *map_complaints, NSError *error) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        data = [[NSMutableArray alloc] initWithArray:map_complaints];
        
        NSArray* annotations = [mapView annotations];
        [mapView removeAnnotations:annotations];
        
        updateMap = YES;
        [self loadLocations:data];
        [complaintTableView reloadData];
        
    }];
}

#pragma mark -
#pragma mark private methods

- (void) setupInterface
{
    [filterButtonItem setTitle:NSLocalizedString(@"Filters", @"Filters")];
    [segmentedMenu setTitle:NSLocalizedString(@"Map", @"Map") forSegmentAtIndex:0];
    [segmentedMenu setTitle:NSLocalizedString(@"List", @"List") forSegmentAtIndex:1];
    
    [menuButtonItem setTarget:self];
    [menuButtonItem setAction:@selector(menuAction)];
    
    [filterButtonItem setTarget:self];
    [filterButtonItem setAction:@selector(filtersAction)];
    
    [mapLeftTab setBackgroundColor:[UIColor clearColor]];
    
    [complaintTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [complaintTableView setContentInset:UIEdgeInsetsMake(0,0,70,0)];
    
    [segmentedMenu addTarget:self action:@selector(segmentedValueChange:) forControlEvents:UIControlEventValueChanged];
    
    mapView.delegate = self;
    updateMap = YES;
    mapView.showsUserLocation = YES;
    
    
    [complaintButton setSelected:YES];
}

- (void) loadLocations:(NSArray*) locations
{
    for (Complaint* complaint in locations) {
        ComplaintPointAnnotation* complaintAnnotation = [[ComplaintPointAnnotation alloc] init];
        complaintAnnotation.coordinate = CLLocationCoordinate2DMake([complaint.location.latitude doubleValue], [complaint.location.longitude doubleValue]);
        complaintAnnotation.title = complaint.complaint_title;
        complaintAnnotation.subtitle = complaint.complaint_description;
        complaintAnnotation.complaint = complaint;
        [mapView addAnnotation:complaintAnnotation];
    }
}

#pragma mark -
#pragma mark Action methods

- (void) segmentedValueChange:(id)sender
{
    UISegmentedControl* segmentedControl = (UISegmentedControl*)sender;
    if (segmentedControl.selectedSegmentIndex == 0) {
        mapView.hidden = NO;
        //refresh_button.hidden = NO;
        mapLeftTab.hidden = NO;
        complaintTableView.hidden = YES;
    }else{
        mapView.hidden = YES;
        //refresh_button.hidden = YES;
        mapLeftTab.hidden = YES;
        complaintTableView.hidden = NO;
    }
}

- (void) menuAction
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

- (void) filtersAction
{
    [self performSegueWithIdentifier:@"filterSegue" sender:nil];
}

- (IBAction)complaintAction:(id)sender
{
    [self performSegueWithIdentifier:@"complaintSegue" sender:nil];
}

- (IBAction)refreshAction:(id)sender
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
    if (![[GlobalManager sharedManager].category_selected isEqualToString:NSLocalizedString(@"All", @"All")]) {
        [params setObject:[GlobalManager sharedManager].category_selected forKey:@"inputSearch"];
    }
    
    [NetworkManager runSearchRequestWithParams:params completition:^(NSArray *map_complaints, NSError *error) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        data = [[NSMutableArray alloc] initWithArray:map_complaints];
        
        NSArray* annotations = [mapView annotations];
        [mapView removeAnnotations:annotations];
        
        [self loadLocations:data];
        [complaintTableView reloadData];
    }];
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
#pragma mark Map methods

- (void)mapView:(MKMapView *)map didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (updateMap) {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 20000, 20000);
        [mapView setRegion:[mapView regionThatFits:region] animated:NO];
        updateMap = NO;
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    id <MKAnnotation> annotation = [view annotation];
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        [self performSegueWithIdentifier:@"detailSegue" sender:nil];
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    //MKAnnotation *selectedAnnotation = view.annotation // This will give the annotation.
    /*if([view.annotation.title isEqualToString:@"yourTitle"])
    {
        // Do something
    }*/
    
    ComplaintPointAnnotation* annotation = [view annotation];
    if ([annotation isKindOfClass:[ComplaintPointAnnotation class]])
    {
        NSLog(@"TITLE: %@", view.annotation.title);
        currentComplaintSelected = annotation.complaint;
        //[self performSegueWithIdentifier:@"detailSegue" sender:nil];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        //MKAnnotationView *pinView = (MKAnnotationView*)[map dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (pinView == nil)
        {
            // If an existing pin view was not available, create one.
            //pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"orange_marker.png"];
            pinView.calloutOffset = CGPointMake(0,19);
            //pinView.draggable = YES;
            // Add a detail disclosure button to the callout.
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            pinView.rightCalloutAccessoryView = rightButton;
            
            // Add an image to the left callout.
            //UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pizza_slice_32.png"]];
            //pinView.leftCalloutAccessoryView = iconView;
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}

#pragma mark -
#pragma mark Segue methods

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"filterSegue"]) {
        FiltersViewController* filtersVC = [segue destinationViewController];
        filtersVC.fromMenu = NO;
    }else if ([segue.identifier isEqualToString:@"detailSegue"]) {
        
        DetailViewController* complaintVC = [segue destinationViewController];
        complaintVC.complaint = currentComplaintSelected;
    }
}

@end
