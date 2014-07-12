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
#import "SignInViewController.h"
#import "MBProgressHUD.h"

#define WANT_INFORMATION_Y_POS_4_INCH            270
#define WANT_UPDATES_Y_POS_4_INCH                321

#define WANT_INFORMATION_Y_POS_3_5_INCH          226
#define WANT_UPDATES_Y_POS_3_5_INCH              277

@interface ComplaintViewController ()
{
    UIImage* chosenImg;
    NSMutableArray* imagesToSend;
    
    
    NSString* finalImageName;
    NSString* icon_name;
    
    int image_tag_selected;
    BOOL max_images_loaded;
    BOOL is_an_anonymous_complaint;
    
    PhotoContainer* next_photo_available;
    PhotoContainer* current_container;
}
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
    
    networkAux = [[NetworkAuxiliar alloc] initWithDelegate:self];
    
    imagesToSend = [[NSMutableArray alloc] initWithCapacity:0];
    chosenImg = nil;
    
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

- (void) loginComplete{
    if ([UserHelper getUserToken]) {
        [anonymous setOn:NO];
        is_an_anonymous_complaint = NO;
    }else{
        [anonymous setOn:YES];
        is_an_anonymous_complaint = YES;
    }
}

#pragma mark -
#pragma mark private methods

- (void) setupPhotoContainers
{
    photo1.tag = 1;
    photo2.tag = 2;
    photo3.tag = 3;
    photo4.tag = 4;
    
    [photo1 setUserInteractionEnabled:YES];
    UITapGestureRecognizer* pictureTapRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageAction:)];
    [pictureTapRecognizer1 setNumberOfTapsRequired:1];
    [pictureTapRecognizer1 setNumberOfTouchesRequired:1];
    [photo1 addGestureRecognizer:pictureTapRecognizer1];
    
    [photo2 setUserInteractionEnabled:YES];
    UITapGestureRecognizer* pictureTapRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageAction:)];
    [pictureTapRecognizer2 setNumberOfTapsRequired:1];
    [pictureTapRecognizer2 setNumberOfTouchesRequired:1];
    [photo2 addGestureRecognizer:pictureTapRecognizer2];
    
    [photo3 setUserInteractionEnabled:YES];
    UITapGestureRecognizer* pictureTapRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageAction:)];
    [pictureTapRecognizer3 setNumberOfTapsRequired:1];
    [pictureTapRecognizer3 setNumberOfTouchesRequired:1];
    [photo3 addGestureRecognizer:pictureTapRecognizer3];
    
    [photo4 setUserInteractionEnabled:YES];
    UITapGestureRecognizer* pictureTapRecognizer4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageAction:)];
    [pictureTapRecognizer4 setNumberOfTapsRequired:1];
    [pictureTapRecognizer4 setNumberOfTouchesRequired:1];
    [photo4 addGestureRecognizer:pictureTapRecognizer4];
    
    photo1.hidden = NO;
    [photo1 loadContainer];
    
    photo2.hidden = YES;
    [photo2 loadContainer];
    
    photo3.hidden = YES;
    [photo3 loadContainer];
    
    photo4.hidden = YES;
    [photo4 loadContainer];
    
    image_tag_selected = photo1.tag;
    max_images_loaded = NO;
}

- (void) setupInterface
{
    self.title = NSLocalizedString(@"Denounce", @"Denounce");
    
    [complaintTitle setPlaceholder:NSLocalizedString(@"Titulo de la denuncia", @"Titulo de la denuncia")];
    [kindOfComplaint setTitle:NSLocalizedString(@"Seleccione el tipo de denuncia", @"Seleccione el tipo de denuncia") forState:UIControlStateNormal];
    //NSString* position_title = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"Ubicacion", @"Ubicacion"),NSLocalizedString(@"Mi ubicacion", @"Mi ubicacion")];
    //[regionButtonAction setTitle:position_title forState:UIControlStateNormal];
    [regionButtonAction setUserInteractionEnabled:NO];
    [dateButton setTitle:NSLocalizedString(@"Elegir Fecha", @"Elegir Fecha") forState:UIControlStateNormal];
    [hourButton setTitle:NSLocalizedString(@"Elegir Hora", @"Elegir Hora") forState:UIControlStateNormal];
    [complaintButton setTitle:NSLocalizedString(@"Denunciar", @"Denunciar") forState:UIControlStateNormal];
    
    
    [commentView setClipsToBounds:YES];
    [commentView.layer setCornerRadius:(float)5.0];
    commentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    commentView.layer.borderWidth = 0.5f;
    
    [self setupPhotoContainers];
    
    [frequently setOn:NO];
    
    [anonymous setOn:YES];
    is_an_anonymous_complaint = YES;
    
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
    
    [complaintButton setSelected:YES];
    [container_scroll setContentSize:CGSizeMake(container_scroll.frame.size.width, 780.0)];
}

- (BOOL) checkFields
{
    if ([kindOfComplaint.titleLabel.text isEqualToString:NSLocalizedString(@"Seleccione el tipo de denuncia", @"Seleccione el tipo de denuncia")]) {
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Por favor, seleccione un tipo de denuncia", @"Por favor, seleccione un tipo de denuncia") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        return NO;
    }
    
    if (!frequently.isOn) {
        
        if ([dateButton.titleLabel.text isEqualToString:NSLocalizedString(@"Fecha", @"Fecha")]) {
            [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Por favor, seleccione una fecha", @"Por favor, seleccione una una fecha") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
            return NO;
        }
        
        
        if ([hourButton.titleLabel.text isEqualToString:NSLocalizedString(@"Hora", @"Hora")]) {
            [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Por favor, seleccione una hora", @"Por favor, seleccione una hora") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
            return NO;
        }
    }
    
    if (complaintTitle.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Por favor, proporcione un titulo a la denuncia", @"Por favor, proporcione un titulo a la denuncia") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        return NO;
    }
    
    
    if (commentView.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Por favor, proporcione un comentario para la denuncia", @"Por favor, proporcione un comentario para la denuncia") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        return NO;
    }
    
    return YES;
}

- (NSDictionary*) createParams
{
    NSString* kind_of_complaint_selected = nil;
    NSString* date_selected = nil;
    NSString* hour_selected = nil;
    NSString* complaint_title = nil;
    NSString* complaint_description = nil;
    
    kind_of_complaint_selected = kindOfComplaint.titleLabel.text;
    
    if (!frequently.isOn) {
        date_selected = dateButton.titleLabel.text;
        hour_selected = hourButton.titleLabel.text;
    }
    
    complaint_title = complaintTitle.text;
    
    complaint_description = commentView.text;
    
    // creamos los parametros
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    if (kind_of_complaint_selected) {
        [params setObject:kind_of_complaint_selected forKey:@"tags"];
        //[params setObject:[NSArray arrayWithObject:kind_of_complaint_selected] forKey:@"tags"];
    }
    
    if (date_selected) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSDate* date = [dateFormatter dateFromString:date_selected];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        NSString* date_formatted = [dateFormatter stringFromDate:date];
        
        [params setObject:date_formatted forKey:@"fecha"];
    }else{
        //[params setObject:@"null" forKey:@"fecha"];
    }
    
    if (hour_selected) {
        [params setObject:hour_selected forKey:@"hora"];
    }else{
        //[params setObject:@"null" forKey:@"hora"];
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
    
    //NSString* region_title = [NSString stringWithFormat:@"%@: ",NSLocalizedString(@"Ubicacion", @"Ubicacion")];
    //NSString* region = [regionButtonAction.titleLabel.text stringByReplacingOccurrencesOfString:region_title withString:@""];
    //[params setObject:region forKey:@"region"];
    
    NSString* position = [NSString stringWithFormat:@"%f,%f",point.coordinate.latitude, point.coordinate.longitude];
    [params setObject:position forKey:@"pos"];
    
    [params setObject:[NSNumber numberWithInt:1] forKey:@"afectados"];
    [params setObject:[NSNumber numberWithInt:0] forKey:@"escierto"];
    [params setObject:[NSNumber numberWithInt:0] forKey:@"nocierto"];
    
    if ([imagesToSend count] > 0) {
        [params setObject:imagesToSend forKey:@"attachs"];
        //NSArray* pictures = [NSArray arrayWithObject:finalImageName];
        //[params setObject:pictures forKey:@"attachs"];
        //[params setObject:pictures forKey:@"fotos"];
    }else{
        //[params setObject:@"[]" forKey:@"attachs"];
        //[params setObject:@"[]" forKey:@"fotos"];
    }
    
    //[params setObject:@"[]" forKey:@"comentarios"];
    [params setObject:icon_name forKey:@"icon"];
    
    if (is_an_anonymous_complaint == NO) {
        [params setObject:[NSNumber numberWithInt:0] forKey:@"anonym"];
    }
    
    NSLog(@"PARAMETROS: %@",params);
    
    return params;
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
    categoryView.category_selected_text = kindOfComplaint.titleLabel.text;
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

- (void) checkImages
{
    int images = 0;
    if (!photo2.hidden) {
        images += 1;
        [imagesToSend addObject:photo1.photoImage.image];
    }
    
    if (!photo3.hidden) {
        images += 1;
        [imagesToSend addObject:photo2.photoImage.image];
    }
    
    if (!photo4.hidden) {
        images += 1;
        [imagesToSend addObject:photo3.photoImage.image];
    }
    
    if (max_images_loaded) {
        images = 4;
        [imagesToSend addObject:photo4.photoImage.image];
    }
    
    NSLog(@"cantidad de imagenes para mandar: %i", images);
}

- (IBAction)complaintButtonAction:(id)sender
{
    if (![self checkFields]) {
        return;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = NSLocalizedString(@"Realizando la denuncia...", @"Realizando la denuncia...");
    
    NSDictionary* params = [self createParams];
    
    NSString* token = nil;
    if (is_an_anonymous_complaint == NO) {
        token = [UserHelper getUserToken];
    }
    
    [NetworkManager runSendComplaintRequestWithParams:params token:token completition:^(NSDictionary *data, NSError *error) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        if (error) {
            [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"No se pudo realizar la denuncia, pruebe mas tarde nuevamente o chequee si conexion a internet",@"No se pudo realizar la denuncia, pruebe mas tarde nuevamente o chequee si conexion a internet") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

/*- (IBAction)complaintButtonAction:(id)sender
{
    if (![self checkFields]) {
        return;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = NSLocalizedString(@"Realizando la denuncia...", @"Realizando la denuncia...");
    
    //if (chosenImg) {
    //    [networkAux uploadPhoto:chosenImg];
    //}
    
    // chequeamos las imagens primero
    [self checkImages];
    
    if ([imagesToSend count] > 0) {
        
        UIImage* image1 = nil;
        UIImage* image2 = nil;
        UIImage* image3 = nil;
        UIImage* image4 = nil;
        
        if (!photo2.hidden) {
            image1 = photo1.photoImage.image;
        }
        
        if (!photo3.hidden) {
            image2 = photo2.photoImage.image;
        }
        
        if (!photo4.hidden) {
            image3 = photo3.photoImage.image;
        }
        
        if (max_images_loaded) {
            image4 = photo4.photoImage.image;
        }
        
        [networkAux uploadPhotos:image1 image2:image2 image3:image3 image4:image4];
    }else{
        
        NSDictionary* params = [self createParams];
        
        NSString* token = nil;
        if (is_an_anonymous_complaint == NO) {
            token = [UserHelper getUserToken];
        }
        
        [NetworkManager runSendComplaintRequestWithParams:params token:token completition:^(NSDictionary *data, NSError *error) {
            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
            
            if (error) {
                [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"No se pudo realizar la denuncia, pruebe mas tarde nuevamente o chequee si conexion a internet",@"No se pudo realizar la denuncia, pruebe mas tarde nuevamente o chequee si conexion a internet") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}*/

- (void)addImageAction:(UITapGestureRecognizer *)gestureRecognizer
{
    //Get the View
    UIImageView *imageSelected = (UIImageView*)gestureRecognizer.view;
    image_tag_selected = imageSelected.tag;
    
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

- (IBAction)anonymousValueChanged:(id)sender
{
    UISwitch* anonymous_switch = (UISwitch*)sender;
    is_an_anonymous_complaint = anonymous_switch.isOn;
    
    if (is_an_anonymous_complaint == NO) {
        NSString* title = NSLocalizedString(@"Advertencia", @"Advertencia");
        NSString* message = NSLocalizedString(@"Si opta por esta opción se publicarán sus datos de usuario", @"Si opta por esta opción se publicarán sus datos de usuario");
        
        [[[UIAlertView alloc] initWithTitle:title
                                    message:message
                                   delegate:self
                          cancelButtonTitle:NSLocalizedString(@"No", @"No")
                          otherButtonTitles:NSLocalizedString(@"Si", @"Si"),nil] show];
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
    chosenImg = chosenImage;
    
    UIImageView* photo = nil;
    current_container = nil;
    next_photo_available = nil;
    switch (image_tag_selected) {
        case 1:
            photo = photo1.photoImage;
            current_container = photo1;
            next_photo_available = photo2;
            break;
        case 2:
            photo = photo2.photoImage;
            current_container = photo2;
            next_photo_available = photo3;
            break;
        case 3:
            photo = photo3.photoImage;
            current_container = photo3;
            next_photo_available = photo4;
            break;
        case 4:
            photo = photo4.photoImage;
            current_container = photo4;
            max_images_loaded = YES;
            break;
    }
    
    if (photo) {
        [photo setClipsToBounds:YES];
        [photo.layer setCornerRadius:(float)5.0];
        [photo setImage:chosenImage];
        photo.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        photo.layer.borderWidth = 0.5f;
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    // uploading picture to server
    [complaintButton setUserInteractionEnabled:NO];
    [complaintButton setTitle:NSLocalizedString(@"Cargando...", @"Cargando...") forState:UIControlStateNormal];
    [complaintButton setTitle:NSLocalizedString(@"Cargando...", @"Cargando...") forState:UIControlStateSelected];
    
    [networkAux uploadPhoto:chosenImage];
    [current_container uploadPicture];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -
#pragma mark Map methods

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[locationView dequeueReusableAnnotationViewWithIdentifier:@"pinAnnotationView"];
        if (pinView == nil)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pinAnnotationView"];
            pinView.draggable = YES;
            [pinView setSelected:YES];
        } else {
            pinView.annotation = annotation;
            [pinView setSelected:YES];
        }
        return pinView;
    }
    return nil;
}

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
    
    
    latitude = [NSString stringWithFormat:@"%f", userLocation.coordinate.latitude];
    longitude = [NSString stringWithFormat:@"%f", userLocation.coordinate.longitude];
    
    if (!point) {
        point = [[MKPointAnnotation alloc] init];
        point.coordinate = userLocation.coordinate;
        point.title = nil;
        point.subtitle = nil;
        [locationView addAnnotation:point];
    }else{
        point.coordinate = userLocation.coordinate;
    }
    

    //NSString* title = [NSString stringWithFormat:@"%.f, %.f", userLocation.coordinate.longitude, userLocation.coordinate.latitude];
    //point.title = title;
    //point.subtitle = @"I'm here!!!";
    
    //point.title = @"Where am I?";
    //point.subtitle = @"I'm here!!!";
    //NSString *display_coordinates=[NSString stringWithFormat:@"Latitude is %f and Longitude is %f",coordinate.longitude,coordinate.latitude];

    
    [locationView addAnnotation:point];
    locationView.showsUserLocation = NO;
}

- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        CLLocationCoordinate2D droppedAt = view.annotation.coordinate;
        point.coordinate = droppedAt;
        //NSLog(@"Pin dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
    }
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

- (void) didFinishCategorySelection:(NSString*)category subcategory:(NSString*)subcategory iconname:(NSString*)iconname
{
    //[kindOfComplaint setTitle:[NSString stringWithFormat:@"%@ - %@", category, subcategory] forState:UIControlStateNormal];
    
    [kindOfComplaint setTitle:[NSString stringWithFormat:@"%@", category] forState:UIControlStateNormal];
    icon_name = iconname;
}

- (void) didFinishRegionSelection:(Region*)region
{
    NSString* region_name = region.region_name;
    
    if ([region_name isEqualToString:NSLocalizedString(@"Mi ubicacion", @"Mi ubicacion")]) {
        locationView.showsUserLocation = YES;
        
        for (id<MKAnnotation> annotation in locationView.annotations){
            MKAnnotationView* anView = [locationView viewForAnnotation: annotation];
            if (anView){
                [anView setDraggable:NO];
            }
        }
        
    }else{
        
        for (id<MKAnnotation> annotation in locationView.annotations){
            MKAnnotationView* anView = [locationView viewForAnnotation: annotation];
            if (anView){
                [anView setDraggable:YES];
            }
        }
        
        latitude = region.region_latitude;
        longitude = region.region_longitude;
        
        locationView.showsUserLocation = NO;
        CLLocationCoordinate2D region_coordinate = CLLocationCoordinate2DMake([region.region_latitude floatValue], [region.region_longitude floatValue]);
        [self updateLocation:region_coordinate];
    }

    NSString* position_title = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"Ubicacion", @"Ubicacion"),region_name];
    [regionButtonAction setTitle:position_title forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark NetworkAuxiliarDelegate methods

/*- (void) connectionDidFinishSuccess:(NSString*) imagename
{
    NSString* name = [imagename stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    finalImageName = name;
    //NSLog(@"finalImageName: -%@-", finalImageName);
    
    NSDictionary* params = [self createParams];
    
    NSString* token = nil;
    if (is_an_anonymous_complaint == NO) {
        token = [UserHelper getUserToken];
    }
    
    [NetworkManager runSendComplaintRequestWithParams:params token:token completition:^(NSDictionary *data, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        if (error) {
            [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"No se pudo realizar la denuncia, pruebe mas tarde nuevamente o chequee si conexion a internet",@"No se pudo realizar la denuncia, pruebe mas tarde nuevamente o chequee si conexion a internet") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}*/

/*- (void) connectionDidFinishError:(NSString*) error_message
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [[[UIAlertView alloc] initWithTitle:nil message:error_message delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
}*/

- (void) connectionDidFinishSuccess:(NSString*) imagename
{
    NSString* name = [imagename stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    [imagesToSend addObject:name];
    //finalImageName = name;
    
    if (next_photo_available) {
        [next_photo_available setHidden:NO];
    }
    
    [current_container.uploadProgress setProgress:1.0];
    [current_container setHidden:NO];
    [current_container setUserInteractionEnabled:NO];
    
    [current_container stopProgress];
    
    [complaintButton setUserInteractionEnabled:YES];
    [complaintButton setTitle:NSLocalizedString(@"Denunciar", @"Denunciar") forState:UIControlStateNormal];
    [complaintButton setTitle:NSLocalizedString(@"Denunciar", @"Denunciar") forState:UIControlStateSelected];
}

- (void) connectionDidFinishError:(NSString*) error_message
{
    [current_container stopProgress];
    [current_container.photoImage setImage:[UIImage imageNamed:@"camera_empty.png"]];
    
    [complaintButton setUserInteractionEnabled:YES];
    [complaintButton setTitle:NSLocalizedString(@"Denunciar", @"Denunciar") forState:UIControlStateNormal];
    [complaintButton setTitle:NSLocalizedString(@"Denunciar", @"Denunciar") forState:UIControlStateSelected];
    
    [[[UIAlertView alloc] initWithTitle:nil message:error_message delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
}

#pragma mark -
#pragma mark AlertViewDelegate methods

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:NSLocalizedString(@"No", @"No")]) {
        [anonymous setOn:YES];
        is_an_anonymous_complaint = YES;
    }else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:NSLocalizedString(@"Si", @"Si")]) {
        if (![UserHelper getUserToken]) {
            [anonymous setOn:YES];
            is_an_anonymous_complaint = YES;
            [self performSegueWithIdentifier:@"toLoginSegue" sender:nil];
        }else{
            is_an_anonymous_complaint = NO;
        }
        
    }
}

#pragma mark -
#pragma mark AlertViewDelegate methods

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toLoginSegue"]) {
        SignInViewController* vc = [segue destinationViewController];
        vc.originController = self;
    }
}


@end
