//
//  ComplaintViewController.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 07/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "ComplaintViewController.h"
#import "SelectCategoryViewController.h"
#import "SelectRegionViewController.h"
#import "MBProgressHUD.h"

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
    NSString* position_title = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"Ubicacion", @"Ubicacion"),NSLocalizedString(@"Mi ubicacion", @"Mi ubicacion")];
    [regionButtonAction setTitle:position_title forState:UIControlStateNormal];
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
    
    point = [[MKPointAnnotation alloc] init];
}

#pragma mark -
#pragma mark Action methods

- (IBAction)kindOfComplaintAction:(id)sender
{
    [self hideDateView];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    UINavigationController *categriesController =
    (UINavigationController*) [storyboard instantiateViewControllerWithIdentifier:@"selectComplaintType"];
    
    SelectCategoryViewController* categoryView = [[categriesController viewControllers] objectAtIndex:0];
    categoryView.delegate = self;
    [self presentViewController:categriesController animated:YES completion:nil];
}

- (IBAction)regionButtonAction:(id)sender
{
    [self hideDateView];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    UINavigationController *regionsController =
    (UINavigationController*) [storyboard instantiateViewControllerWithIdentifier:@"selectRegion"];
    
    SelectRegionViewController* regionsView = [[regionsController viewControllers] objectAtIndex:0];
    regionsView.delegate = self;
    [self presentViewController:regionsController animated:YES completion:nil];
}

- (IBAction)dateButtonAction:(id)sender
{
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [self showDateView];
}

- (IBAction)hourButtonAction:(id)sender
{
    [datePicker setDatePickerMode:UIDatePickerModeTime];
    [self showDateView];
}

- (IBAction)complaintButtonAction:(id)sender
{
    NSString* kind_of_complaint_selected = nil;
    NSString* date_selected = nil;
    NSString* hour_selected = nil;
    NSString* complaint_title = nil;
    NSString* complaint_description = nil;
    
    if ([kindOfComplaint.titleLabel.text isEqualToString:NSLocalizedString(@"Tipo de denuncia", @"Tipo de denuncia")]) {
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Por favor, seleccione un tipo de denuncia", @"Por favor, seleccione un tipo de denuncia") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        return;
    }else
        kind_of_complaint_selected = kindOfComplaint.titleLabel.text;
    
    if (!frequently.isOn) {
        
        if ([dateButton.titleLabel.text isEqualToString:NSLocalizedString(@"Fecha", @"Fecha")]) {
            [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Por favor, seleccione una fecha", @"Por favor, seleccione una una fecha") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
            return;
        }else
            date_selected = dateButton.titleLabel.text;
        
        
        if ([hourButton.titleLabel.text isEqualToString:NSLocalizedString(@"Hora", @"Hora")]) {
            [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Por favor, seleccione una hora", @"Por favor, seleccione una hora") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
            return;
        }else
            hour_selected = hourButton.titleLabel.text;
    }
    
    if (complaintTitle.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Por favor, proporcione un titulo a la denuncia", @"Por favor, proporcione un titulo a la denuncia") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        return;
    }else
        complaint_title = complaintTitle.text;
    
    
    if (commentView.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Por favor, proporcione un comentario para la denuncia", @"Por favor, proporcione un comentario para la denuncia") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        return;
    }else
        complaint_description = commentView.text;
    
    
    // creamos los parametros
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    if (kind_of_complaint_selected) {
        [params setObject:[NSArray arrayWithObject:kind_of_complaint_selected] forKey:@"tags"];
    }
    
    if (date_selected) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSDate* date = [dateFormatter dateFromString:date_selected];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        NSString* date_formatted = [dateFormatter stringFromDate:date];
        
        [params setObject:date_formatted forKey:@"fecha"];
    }else{
        [params setObject:@"null" forKey:@"fecha"];
    }
    
    if (hour_selected) {
        [params setObject:hour_selected forKey:@"hora"];
    }else{
        [params setObject:@"null" forKey:@"hora"];
    }
    
    if (frequently.isOn) {
        [params setObject:@"true" forKey:@"frecuentemente"];
    }else{
        [params setObject:@"false" forKey:@"frecuentemente"];
    }
    
    if (complaint_title) {
        [params setObject:complaint_title forKey:@"titulo"];
    }
    
    if (complaint_description) {
        [params setObject:complaint_description forKey:@"descripcion"];
    }
    
    NSString* region_title = [NSString stringWithFormat:@"%@: ",NSLocalizedString(@"Ubicacion", @"Ubicacion")];
    NSString* region = [regionButtonAction.titleLabel.text stringByReplacingOccurrencesOfString:region_title withString:@""];
    [params setObject:region forKey:@"region"];
    
    NSString* position = [NSString stringWithFormat:@"%@,%@",latitude, longitude];
    [params setObject:position forKey:@"pos"];
    
    [params setObject:[NSNumber numberWithInt:1] forKey:@"afectados"];
    [params setObject:[NSNumber numberWithInt:0] forKey:@"escierto"];
    [params setObject:[NSNumber numberWithInt:0] forKey:@"nocierto"];
    
    [params setObject:@"terrorismo.png" forKey:@"icon"];
    
    NSLog(@"PARAMETROS: %@",params);
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = NSLocalizedString(@"Realizando la denuncia...", @"Realizando la denuncia...");
    
    [NetworkManager runSendComplaintRequestWithParams:params completition:^(NSDictionary *data, NSError *error) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        if (error) {
            [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"No se pudo realizar la denuncia, pruebe mas tarde nuevamente o chequee si conexion a internet",@"No se pudo realizar la denuncia, pruebe mas tarde nuevamente o chequee si conexion a internet") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }];
}

- (IBAction)addImageAction:(id)sender
{
    [self hideDateView];
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

- (void) textFieldDidBeginEditing:(UITextField *)textField{
    [self hideDateView];
}

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
    [self hideDateView];
    
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

- (void) updateLocation:(CLLocationCoordinate2D)coordinate
{
    point.coordinate = coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 20000, 20000);
    [locationView setRegion:[locationView regionThatFits:region] animated:YES];
    [locationView addAnnotation:point];
}

- (void)mapView:(MKMapView *)map didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 2000, 2000);
    [locationView setRegion:[locationView regionThatFits:region] animated:YES];
    
    // Add an annotation
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
    
    if ([pickerDate compare:[NSDate date]] == NSOrderedDescending ) {
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"La fecha seleccionada es mayor a la actual", @"La fecha seleccionada es mayor a la actual") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        return;
    }
    
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

#pragma mark -
#pragma mark ComplaintDelegate methods

- (void) didFinishCategorySelection:(NSString*)category subcategory:(NSString*)subcategory
{
    [kindOfComplaint setTitle:[NSString stringWithFormat:@"%@ - %@", category, subcategory] forState:UIControlStateNormal];
}

- (void) didFinishRegionSelection:(Region*)region
{
    NSString* region_name = region.region_name;
    
    if ([region_name isEqualToString:NSLocalizedString(@"Mi ubicacion", @"Mi ubicacion")]) {
        locationView.showsUserLocation = YES;
    }else{
        
        latitude = region.region_latitude;
        longitude = region.region_longitude;
        
        locationView.showsUserLocation = NO;
        CLLocationCoordinate2D region_coordinate = CLLocationCoordinate2DMake([region.region_latitude floatValue], [region.region_longitude floatValue]);
        [self updateLocation:region_coordinate];
    }

    NSString* position_title = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"Ubicacion", @"Ubicacion"),region_name];
    [regionButtonAction setTitle:position_title forState:UIControlStateNormal];
}

@end
