//
//  ComplaintViewController.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 07/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ComplaintViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextViewDelegate, MKMapViewDelegate>
{
    __weak IBOutlet UIImageView* photoImageView;
    __weak IBOutlet UITextView* commentView;
    __weak IBOutlet UILabel* commentPlaceholder;
    __weak IBOutlet UILabel* kindOfComplaint;
    __weak IBOutlet MKMapView* locationView;
    
    __weak IBOutlet UISwitch* wantInformation;
    __weak IBOutlet UILabel* wantInformationLabel;
    
    __weak IBOutlet UISwitch* wantUpdates;
    __weak IBOutlet UILabel* wantUpdatesLabel;
    
    __weak IBOutlet UILabel* informationButton;
    __weak IBOutlet UILabel* complaintButton;
}

- (IBAction)wantInformationValueChanged:(id)sender;
- (IBAction)wantUpdateValueChanged:(id)sender;

@end
