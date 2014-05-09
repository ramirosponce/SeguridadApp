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

@interface MainScreenViewController ()
{
    NSMutableArray* data;
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
    NSArray* data_temp = [DataHelper getMapData];
    for (NSDictionary* dic in data_temp) {
        Complaint* complaint = [[Complaint alloc] initWithData:dic];
        [data addObject:complaint];
    }
    
    [self loadLocations:data];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    
    [segmentedMenu addTarget:self action:@selector(segmentedValueChange:) forControlEvents:UIControlEventValueChanged];
    
    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    
    NSLog(@"adasdasdas");
    [[[UIAlertView alloc] initWithTitle:nil message:@"sdfsdf" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
}

- (void) loadLocations:(NSArray*) locations
{
    for (Complaint* complaint in locations) {
        MKPointAnnotation* complaintAnnotation = [[MKPointAnnotation alloc] init];
        complaintAnnotation.coordinate = CLLocationCoordinate2DMake([complaint.location.latitude doubleValue], [complaint.location.longitude doubleValue]);
        complaintAnnotation.title = complaint.complaint_title;
        complaintAnnotation.subtitle = complaint.complaint_description;
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
        mapLeftTab.hidden = NO;
        complaintTableView.hidden = YES;
    }else{
        mapView.hidden = YES;
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
    
    Complaint* complaint = [data objectAtIndex:indexPath.row];
    [cell populateCell:complaint];
    
    return cell;
}

#pragma mark -
#pragma mark Map methods

- (void)mapView:(MKMapView *)map didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1000, 1000);
    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    id <MKAnnotation> annotation = [view annotation];
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        NSLog(@"Clicked Pizza Shop");
    }
    [[[UIAlertView alloc] initWithTitle:nil message:@"ir a detalle" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
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
            //pinView.image = [UIImage imageNamed:@"pizza_slice_32.png"];
            //pinView.calloutOffset = CGPointMake(0, 32);
            
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

@end
