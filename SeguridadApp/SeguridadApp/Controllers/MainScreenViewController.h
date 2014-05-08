//
//  MainScreenViewController.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 05/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MainScreenViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate>
{
    __weak IBOutlet UISegmentedControl* segmentedMenu;
    __weak IBOutlet UIBarButtonItem* menuButtonItem;
    __weak IBOutlet UIBarButtonItem* filterButtonItem;
    __weak IBOutlet MKMapView* mapView;
    __weak IBOutlet UITableView* complaintTableView;
    __weak IBOutlet UIView* mapLeftTab;
}

- (IBAction)complaintAction:(id)sender;

@end
