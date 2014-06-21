//
//  ComplaintViewController.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 07/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Region.h"
#import "NetworkAuxiliar.h"

@protocol ComplaintDelegate <NSObject>

@optional

- (void) didFinishCategorySelection:(NSString*)category subcategory:(NSString*)subcategory iconname:(NSString*)iconname;
- (void) didFinishRegionSelection:(Region*)region;

@end

@interface ComplaintViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextViewDelegate, MKMapViewDelegate, UITextFieldDelegate, ComplaintDelegate, MKAnnotation,NetworkAuxiliarDelegate, UIAlertViewDelegate>
{
    __weak IBOutlet UIImageView* photoImageView;
    
    __weak IBOutlet UIImageView* photo1;
    __weak IBOutlet UIImageView* photo2;
    __weak IBOutlet UIImageView* photo3;
    __weak IBOutlet UIImageView* photo4;
    
    __weak IBOutlet UITextField* complaintTitle;
    __weak IBOutlet UITextView* commentView;
    
    __weak IBOutlet UILabel* commentPlaceholder;
    __weak IBOutlet UIButton* kindOfComplaint;
    __weak IBOutlet UIButton* regionButtonAction;
    __weak IBOutlet MKMapView* locationView;
    
    __weak IBOutlet UISwitch* anonymous;
    __weak IBOutlet UISwitch* frequently;
    __weak IBOutlet UIButton* dateButton;
    __weak IBOutlet UIButton* hourButton;
    
    __weak IBOutlet UIButton* complaintButton;
    __weak IBOutlet UIButton* dateSelected;
    __weak IBOutlet UIView* dateView;
    __weak IBOutlet UIDatePicker* datePicker;
    
    __weak IBOutlet UIScrollView* container_scroll;
    
    
    NSString* latitude;
    NSString* longitude;
    MKPointAnnotation *point;
    
    NetworkAuxiliar* networkAux;
    
}

- (IBAction)frequentlyValueChanged:(id)sender;
- (IBAction)anonymousValueChanged:(id)sender;

- (IBAction)kindOfComplaintAction:(id)sender;
- (IBAction)regionButtonAction:(id)sender;

- (IBAction)dateButtonAction:(id)sender;
- (IBAction)hourButtonAction:(id)sender;
- (IBAction)complaintButtonAction:(id)sender;


@end
