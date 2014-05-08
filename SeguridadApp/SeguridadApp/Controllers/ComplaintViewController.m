//
//  ComplaintViewController.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 07/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "ComplaintViewController.h"

#define WANT_INFORMATION_Y_POS_4_INCH            270
#define WANT_UPDATES_Y_POS_4_INCH                321

#define WANT_INFORMATION_Y_POS_3_5_INCH          226
#define WANT_UPDATES_Y_POS_3_5_INCH              277

@interface ComplaintViewController ()

@end

@implementation ComplaintViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self dismissImputController];
}

#pragma mark -
#pragma mark private methods

- (void) setupInterface
{
    self.title = NSLocalizedString(@"Denounce", @"Denounce");
    
    [commentView setClipsToBounds:YES];
    [commentView.layer setCornerRadius:(float)5.0];
    commentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    commentView.layer.borderWidth = 0.5f;
    
    [photoImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer* pictureTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageAction:)];
    [pictureTapRecognizer setNumberOfTapsRequired:1];
    [pictureTapRecognizer setNumberOfTouchesRequired:1];
    [photoImageView addGestureRecognizer:pictureTapRecognizer];
    
    [wantInformation setOn:YES];
    [wantUpdates setOn:NO];
    
    CGRect wantInformationFrame = wantInformation.frame;
    CGRect wantInformationLabelFrame = wantInformationLabel.frame;
    CGRect wantUpdatesFrame = wantUpdates.frame;
    CGRect wantUpdatesLabelFrame = wantUpdatesLabel.frame;
    
    if (IS_IPHONE_5) {
        wantInformationFrame.origin.y = WANT_INFORMATION_Y_POS_4_INCH;
        wantInformationLabelFrame.origin.y = WANT_INFORMATION_Y_POS_4_INCH;
        wantUpdatesFrame.origin.y = WANT_UPDATES_Y_POS_4_INCH;
        wantUpdatesLabelFrame.origin.y = WANT_UPDATES_Y_POS_4_INCH;
    }else{
        wantInformationFrame.origin.y = WANT_INFORMATION_Y_POS_3_5_INCH;
        wantInformationLabelFrame.origin.y = WANT_INFORMATION_Y_POS_3_5_INCH;
        wantUpdatesFrame.origin.y = WANT_UPDATES_Y_POS_3_5_INCH;
        wantUpdatesLabelFrame.origin.y = WANT_UPDATES_Y_POS_3_5_INCH;
    }
    
    wantInformation.frame = wantInformationFrame;
    wantInformationLabel.frame = wantInformationLabelFrame;
    wantUpdates.frame = wantUpdatesFrame;
    wantUpdatesLabel.frame = wantUpdatesLabelFrame;
    
    
    [kindOfComplaint setUserInteractionEnabled:YES];
    UITapGestureRecognizer* kindOfComplaintGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kindOfComplaintAction:)];
    [kindOfComplaintGesture setNumberOfTapsRequired:1];
    [kindOfComplaint addGestureRecognizer:kindOfComplaintGesture];
    
    [informationButton setUserInteractionEnabled:YES];
    UITapGestureRecognizer* informationButtonGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(informationButtonAction:)];
    [informationButtonGesture setNumberOfTapsRequired:1];
    [informationButton addGestureRecognizer:informationButtonGesture];
    
    [complaintButton setUserInteractionEnabled:YES];
    UITapGestureRecognizer* complaintButtonGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(complaintButtonAction:)];
    [complaintButtonGesture setNumberOfTapsRequired:1];
    [complaintButton addGestureRecognizer:complaintButtonGesture];
    
    locationView.delegate = self;
    locationView.showsUserLocation = YES;
    
    [self.view setUserInteractionEnabled:YES];
    UITapGestureRecognizer* viewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissImputController)];
    [viewGesture setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:viewGesture];
    
}

#pragma mark -
#pragma mark Action methods

- (void) kindOfComplaintAction:(UITapGestureRecognizer*) tapGesture
{
    [[[UIAlertView alloc] initWithTitle:nil message:@"kind button action" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (void) informationButtonAction:(UITapGestureRecognizer*) tapGesture
{
    [[[UIAlertView alloc] initWithTitle:nil message:@"information button action" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (void) complaintButtonAction:(UITapGestureRecognizer*) tapGesture
{
    [[[UIAlertView alloc] initWithTitle:nil message:@"denunciar button action" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (IBAction)addImageAction:(id)sender
{
    [self dismissImputController];
    
    UIActionSheet* pictureActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                    delegate:self
                                                           cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
                                                      destructiveButtonTitle:nil
                                                           otherButtonTitles:NSLocalizedString(@"Camera", @"Camera"),NSLocalizedString(@"Select a Picture", @"Select a Picture"), nil];
    [pictureActionSheet showInView:self.view];
}

- (void) dismissImputController
{
    [commentView resignFirstResponder];
}

- (IBAction)wantInformationValueChanged:(id)sender
{
    NSLog(@"-- wantInformationValueChanged --");
}

- (IBAction)wantUpdateValueChanged:(id)sender
{
    NSLog(@"** wantUpdateValueChanged **");
}

#pragma mark -
#pragma mark UIActionSheetDelegate implementation

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:NSLocalizedString(@"Camera", @"Camera")])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
    }else if  ([buttonTitle isEqualToString:NSLocalizedString(@"Select a Picture", @"Select a Picture")])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
}

#pragma mark -
#pragma mark UITextViewDelegate methods

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(commentView.text.length == 0){
        commentPlaceholder.hidden = NO;
    }else{
        commentPlaceholder.hidden = YES;
    }
}

#pragma mark -
#pragma mark imagePicker methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    
    [photoImageView setClipsToBounds:YES];
    [photoImageView.layer setCornerRadius:(float)5.0];
    [photoImageView setImage:chosenImage];
    
    photoImageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    photoImageView.layer.borderWidth = 0.5f;

    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -
#pragma mark Map methods

- (void)mapView:(MKMapView *)map didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 100, 100);
    [locationView setRegion:[locationView regionThatFits:region] animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    
    //NSString* title = [NSString stringWithFormat:@"%.f, %.f", userLocation.coordinate.longitude, userLocation.coordinate.latitude];
    //point.title = title;
    //point.subtitle = @"I'm here!!!";
    
    //point.title = @"Where am I?";
    //point.subtitle = @"I'm here!!!";
    //NSString *display_coordinates=[NSString stringWithFormat:@"Latitude is %f and Longitude is %f",coordinate.longitude,coordinate.latitude];

    
    [locationView addAnnotation:point];
}

@end
