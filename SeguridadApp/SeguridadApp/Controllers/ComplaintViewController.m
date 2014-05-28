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
    /*
     Params for denuncia
     {
     afectados: 1,
     attachs: [],
     comentarios: [],
     descripcion: "ASSSSSSS",
     escierto: 0,
     fecha: null,
     fotos: ["sinfoto.jpg", "fghj.jpg"],
     frecuentemente: true,
     hora: null,
     icon: "terrorismo.png",
     nocierto: 0,
     pos: "18.471009514707436,-69.80233798851259", //posicion del marcador en
     el mapa
     region: "Los Frailes",
     tags: ["Terrorismo - Existencia de explosivos"],
     titulo: "TEST2",
     }
     */
    [[[UIAlertView alloc] initWithTitle:nil message:@"denunciar button action" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    NSDate * date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSString* fecha = [dateFormatter stringFromDate:date];
    
    [dateFormatter setDateFormat:@"HH:mm aa"];
    NSString* hora = [dateFormatter stringFromDate:date];
    
    NSLog(@"fecha y hora = %@ - %@", fecha,  hora);
    
    NSString* pos = [NSString stringWithFormat:@"%@,%@", latitude, longitude];
    
    NSLog(@"Location after calibration, user location (%@)", pos);
    
    if (commentView.text.length == 0) {
        
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"You must complete all fields.",@"You must complete all fields.") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        
        return;
    }
    //NSArray* commentArray = [NSArray arrayWithObject:commentView.text];
    
    NSDictionary* params = @{@"descripcion": commentView.text,
                             //@"afectados": , Preguntar que es!
                             //@"attachs": ,
                             //@"comentarios": , No se puede mandar
                             //@"escierto": ,No se puede mandar
                             //@"nocierto": ,No se puede mandar
                             @"frecuentemente": @"false",
                             //@"region": , No tiene sentido
                             @"icon": @"terrorismo.png",
                             //@"tags": ,
                             @"titulo": @"Denuncia M",
                             //@"fotos": ,
                             @"pos": pos,
                             @"hora": hora,
                             @"fecha": fecha,
                             @"from": @"iPhone"};
    [NetworkManager runSendComplaintRequestWithParams:params completition:^(NSDictionary *data, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        if (!data) {
            [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Something is wrong, please try again later.","Something is wrong, please try again later.") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        }else{
            ////NSLog(@"ERROR= %@", error.description);
            NSString* response = @"hola";//[data objectForKey:@"res"];
            NSLog(@"DATA= %@",data);
            if ([response isEqualToString:SIGN_UP_OK]) {
                [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Denuncia successfully.","Denuncia successfully.") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
                // go to main scren or do something
            }
            
        }
    }];
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
    
    latitude = [NSString stringWithFormat:@"%f", userLocation.coordinate.latitude];
    longitude = [NSString stringWithFormat:@"%f", userLocation.coordinate.longitude];

    //NSString* title = [NSString stringWithFormat:@"%.f, %.f", userLocation.coordinate.longitude, userLocation.coordinate.latitude];
    //point.title = title;
    //point.subtitle = @"I'm here!!!";
    
    //point.title = @"Where am I?";
    //point.subtitle = @"I'm here!!!";
    //NSString *display_coordinates=[NSString stringWithFormat:@"Latitude is %f and Longitude is %f",coordinate.longitude,coordinate.latitude];

    
    [locationView addAnnotation:point];
}

@end
