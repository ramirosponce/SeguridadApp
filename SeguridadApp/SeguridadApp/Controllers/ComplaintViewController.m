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
    
    [complaintTitle setPlaceholder:NSLocalizedString(@"Titulo de la denuncia", @"Titulo de la denuncia")];
    [kindOfComplaint setTitle:NSLocalizedString(@"Tipo de denuncia", @"Tipo de denuncia") forState:UIControlStateNormal];
    [dateButton setTitle:NSLocalizedString(@"Fecha", @"Fecha") forState:UIControlStateNormal];
    [hourButton setTitle:NSLocalizedString(@"Hora", @"Hora") forState:UIControlStateNormal];
    [complaintButton setTitle:NSLocalizedString(@"Denunciar", @"Denunciar") forState:UIControlStateNormal];
    
    
    [commentView setClipsToBounds:YES];
    [commentView.layer setCornerRadius:(float)5.0];
    commentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    commentView.layer.borderWidth = 0.5f;
    
    [photoImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer* pictureTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageAction:)];
    [pictureTapRecognizer setNumberOfTapsRequired:1];
    [pictureTapRecognizer setNumberOfTouchesRequired:1];
    [photoImageView addGestureRecognizer:pictureTapRecognizer];
    
    [frequently setOn:NO];
    
    
    locationView.delegate = self;
    locationView.showsUserLocation = YES;
    
    [self.view setUserInteractionEnabled:YES];
    UITapGestureRecognizer* viewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissImputController)];
    [viewGesture setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:viewGesture];
    
    // set bar items actions
    //[doneBarItem setAction:@selector(hideDateView)];
    
    CGRect pickerContainerFrame = dateView.frame;
    pickerContainerFrame.origin.y = [[UIScreen mainScreen] bounds].size.height;
    dateView.frame = pickerContainerFrame;
    
    [dateView.layer setShadowColor:[UIColor blackColor].CGColor];
    [dateView.layer setShadowOpacity:0.8];
    [dateView.layer setShadowRadius:3.0];
    [dateView.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
    [dateView.layer setCornerRadius:5.0f];
    
}

#pragma mark -
#pragma mark Action methods

- (IBAction)kindOfComplaintAction:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:nil message:@"kind button action" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (IBAction)dateButtonAction:(id)sender
{
    
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    
    NSString* date_selected = dateSelected.titleLabel.text;
    
    
    [self showDateView];
}

- (IBAction)hourButtonAction:(id)sender
{
    [datePicker setDatePickerMode:UIDatePickerModeTime];
    [self showDateView];
}

- (IBAction)complaintButtonAction:(id)sender
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

- (IBAction)frequentlyValueChanged:(id)sender
{
    UISwitch* switch_frequently = (UISwitch*)sender;
    if (switch_frequently.isOn) {
        [dateButton setEnabled:NO];
        [hourButton setEnabled:NO];
    }else{
        [dateButton setEnabled:YES];
        [hourButton setEnabled:YES];
    }
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
#pragma mark UITextfieldDelegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [commentView becomeFirstResponder];
    return NO;
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
     
#pragma mark -
#pragma mark Date picker view methods

// dateSelected

- (IBAction)doneDateAction:(id)sender{
    
    NSDate *pickerDate = [datePicker date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    if (datePicker.datePickerMode == UIDatePickerModeDate) {
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSString *selectionString = [dateFormatter stringFromDate:pickerDate];
        [dateButton setTitle:selectionString forState:UIControlStateNormal];
    }else{
        [dateFormatter setDateFormat:@"K:mm a"];
        NSString *selectionString = [dateFormatter stringFromDate:pickerDate];
        [hourButton setTitle:selectionString forState:UIControlStateNormal];
    }
    
    [self hideDateView];
}

- (void) hideDateView
{
    CGRect pickerContainerFrame = dateView.frame;
    pickerContainerFrame.origin.y = self.view.frame.size.height;
    
    [UIView animateWithDuration:0.2 animations:^{
        dateView.frame = pickerContainerFrame;
    }];
}

- (void) showDateView
{
    CGRect pickerContainerFrame = dateView.frame;
    pickerContainerFrame.origin.y = self.view.frame.size.height - pickerContainerFrame.size.height;
    
    [UIView animateWithDuration:0.2 animations:^{
        dateView.frame = pickerContainerFrame;
    }];
}



@end
