//
//  DetailViewController.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailComplaintCell.h"
#import "DetailPicturesCell.h"
#import "DetailFeelingCell.h"
#import "DetailCommentCell.h"

#import "Complaint.h"
#import "DetailUserCell.h"
#import "Comment.h"
#import "DataHelper.h"
#import "MBProgressHUD.h"

#import "SignInViewController.h"

#import "FSBasicImage.h"
#import "FSBasicImageSource.h"
#import "FSImageViewerViewController.h"

#define SECTIONS    5

@interface DetailViewController ()
{
    NSArray* comments;
    NSMutableArray* commentsHeights;
    BOOL keyboardIsShowed;
    
    // variables para guardar los valores actuales para
    // la informacion de afecta / es verdad / no es verda
    int affected;
    int isTrue;
    int isNotTrue;
    
}
@end

@implementation DetailViewController

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
    
    affected = self.complaint.affected;
    isTrue = self.complaint.isTrue;
    isNotTrue = self.complaint.isntTrue;
    
    NSLog(@"lat: %@, long: %@",self.complaint.location.latitude, self.complaint.location.longitude);
    
    self.selectedLocation = CLLocationCoordinate2DMake([self.complaint.location.latitude doubleValue],
                                                           [self.complaint.location.longitude doubleValue]);
    
    //comments = [[NSArray alloc] initWithArray:self.complaint.comments];
    [self setupInterface];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setupKeyboardNotifications];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = NSLocalizedString(@"Cargando comentarios...", @"Cargando comentarios...");
    
    [NetworkManager runFindById:self.complaint.complaint_id completition:^(NSArray *comments_aux, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        comments = [[NSArray alloc] initWithArray:comments_aux];
        
        commentsHeights = [[NSMutableArray alloc] initWithCapacity:0];
        for (Comment* comment in comments) {
            CGFloat height = [self getCommentCellHeight2:comment];
            [commentsHeights addObject:[NSNumber numberWithFloat:height]];
        }
        
        [self.tableView reloadData];
    }];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self removeKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (pinView == nil)
        {
            // If an existing pin view was not available, create one.
            //pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"orange_marker.png"];
            pinView.calloutOffset = CGPointMake(0,19);
            
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
#pragma mark private methods

- (void) setupInterface
{
    self.title = NSLocalizedString(@"Detalle", @"Detalle");
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UIBarButtonItem* options = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAction:)];
    self.navigationItem.rightBarButtonItem = options;
    
    
    [self setupCommentInterface];
    
    CGRect tableFrame = self.tableView.frame;
    tableFrame.size.height -= containerView.frame.size.height;
    self.tableView.frame = tableFrame;
    
    keyboardIsShowed = NO;
}

- (void) removeKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void) setupKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) setupCommentInterface
{
    containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, 320, 40)];
    
	textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 3, 240, 40)];
    textView.isScrollable = NO;
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
	textView.minNumberOfLines = 1;
	textView.maxNumberOfLines = 3;
    // you can also set the maximum height in points with maxHeight
    // textView.maxHeight = 200.0f;
	textView.returnKeyType = UIReturnKeyGo; //just as an example
	textView.font = [UIFont systemFontOfSize:15.0f];
	textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor whiteColor];
    textView.placeholder = NSLocalizedString(@"Ingrese su comentario", @"Ingrese su comentario");
    [textView setReturnKeyType:UIReturnKeyDefault];
    
    // textView.text = @"test\n\ntest";
	// textView.animateHeightChange = NO; //turns off animation
    
    [self.view addSubview:containerView];
    
    UIImage *rawEntryBackground = [UIImage imageNamed:@"MessageEntryInputField.png"];
    UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *entryImageView = [[UIImageView alloc] initWithImage:entryBackground];
    entryImageView.frame = CGRectMake(5, 0, 248, 40);
    entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UIImage *rawBackground = [UIImage imageNamed:@"MessageEntryBackground.png"];
    UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    imageView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // view hierachy
    [containerView addSubview:imageView];
    [containerView addSubview:textView];
    [containerView addSubview:entryImageView];
    
    UIImage *sendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    UIImage *selectedSendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    
	UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	doneBtn.frame = CGRectMake(containerView.frame.size.width - 69, 8, 63, 27);
    doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
	[doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    
    [doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
    doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
    doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[doneBtn addTarget:self action:@selector(sendComment) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
	[containerView addSubview:doneBtn];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

- (void) sendComment
{
    [textView resignFirstResponder];
    
    if (textView.text.length == 0) return;
    
    if (![UserHelper getUserToken]) {
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Para poder realizar un comentario debe estar logueado.", @"Para poder realizar un comentario debe estar logueado") delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        return;
    }
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:textView.text forKey:@"comment"];
    [params setObject:self.complaint.complaint_id forKey:@"id"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = NSLocalizedString(@"Enviando...", @"Enviando...");
    
    [NetworkManager sendCommentWithParams:params token:[UserHelper getUserToken] completition:^(NSDictionary *data, NSError *error, NSString *error_message) {
        
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        if (error) {
            [[[UIAlertView alloc] initWithTitle:nil message:error_message delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        }else{
            NSString* response = [data objectForKey:@"res"];
            if ([response isEqualToString:SIGN_UP_OK]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
}

#pragma mark -
#pragma mark Keyboards methods

//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{
    
    keyboardIsShowed = YES;
    
    // get keyboard size and loctaion
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
	// get a rect for the textView frame
	CGRect containerFrame = containerView.frame;
    CGRect tableFrame = self.tableView.frame;
    
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    tableFrame.size.height = containerFrame.origin.y - tableFrame.origin.y;
    
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
	
	// set views with new info
	containerView.frame = containerFrame;
    self.tableView.frame = tableFrame;
	
	// commit animations
	[UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    
    keyboardIsShowed = NO;
    
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
	
	// get a rect for the textView frame
	CGRect containerFrame = containerView.frame;
    CGRect tableFrame = self.tableView.frame;
    
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
	tableFrame.size.height = containerFrame.origin.y - tableFrame.origin.y;
    
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
	// set views with new info
	containerView.frame = containerFrame;
	self.tableView.frame = tableFrame;
	// commit animations
	[UIView commitAnimations];
    
}

#pragma mark - 
#pragma mark Actions methods

- (void) shareAction:(id)sender
{
    NSString *shareString = NSLocalizedString(@"Estoy usando la aplicacion de seguridad para hacer denuncias en mi iphone.",@"Estoy usando la aplicacion de seguridad para hacer denuncias en mi iphone.");
    NSURL *shareUrl = [NSURL URLWithString:@"http://appseguridad.avec.com.do/app"];
    
    NSArray *activityItems = [NSArray arrayWithObjects:shareString, shareUrl, nil];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:activityViewController animated:YES completion:nil];
    //UIActionSheet* actionsheet = [[UIActionSheet alloc] initWithTitle:nil
    //                                                         delegate:self
    //                                                cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
    //                                           destructiveButtonTitle:nil
    //                                                otherButtonTitles:NSLocalizedString(@"Share on Facebook", @"Share on Facebook"), NSLocalizedString(@"Share on Twitter", @"Share on Twitter"),NSLocalizedString(@"Share on Mail",@"Share on Mail"), nil];
    //[actionsheet showInView:self.view];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberOfRows = 0;
    if (section == 4) {
        numberOfRows = [comments count];
    }else{
        numberOfRows = 1;
    }
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"DetailComplaintCell";
        DetailComplaintCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"DetailComplaintCell" bundle:nil] forCellReuseIdentifier:identifier];
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell populateCell:self.complaint];
        return cell;
    }else if (indexPath.section == 1){
        static NSString *identifier = @"DetailPicturesCell";
        DetailPicturesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"DetailPicturesCell" bundle:nil] forCellReuseIdentifier:identifier];
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        [cell populateCell:self.complaint.attachs];
        return cell;
    }else if (indexPath.section == 2){
        static NSString* identifier = @"DetailFeelingCell";
        DetailFeelingCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"DetailFeelingCell" bundle:nil] forCellReuseIdentifier:identifier];
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        
        [cell populateCellWithAffected:affected isTrue:isTrue isntTrue:isNotTrue];
        
        return cell;
    }else if (indexPath.section == 3){
        
        static NSString* identifier = @"DetailUserCell";
        DetailUserCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"DetailUserCell" bundle:nil] forCellReuseIdentifier:identifier];
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell populateCell:self.complaint.user isAnonymous:self.complaint.isAnonymous];
        return cell;
        
    }else{
        static NSString* identifier = @"DetailCommentCell";
        DetailCommentCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"DetailCommentCell" bundle:nil] forCellReuseIdentifier:identifier];
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        Comment* comment = [comments objectAtIndex:indexPath.row];
        [cell populateCell:comment];
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    switch (indexPath.section) {
        case 0:
            height = 183.0;
            break;
        case 1:
            if (self.complaint.attachs.count > 0) {
                height = 75.0;
            }
            break;
        case 2:
            height = 54.0;
            break;
        case 3:
            height = 60.0;
            if (self.complaint.isAnonymous)
                height = 44.0;
            break;
        case 4:
            //height = [self getCommentCellHeight:indexPath];
            height = [[commentsHeights objectAtIndex:indexPath.row] floatValue];
            break;
    }
    return height;
}

- (CGFloat)getCommentCellHeight:(NSIndexPath *)indexPath
{
    Comment* comment = (Comment*)[comments objectAtIndex:indexPath.row];
    
    CGRect titleFrame = CGRectMake(55.0, 8.0, 245.0, 21.0);
    CGRect commentFrame = CGRectMake(55.0, 27.0, 245.0, 21.0);
    
    UIFont* titleFont = [UIFont boldSystemFontOfSize:16.0];
    NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:titleFont forKey: NSFontAttributeName];
    
    /* title */
    CGSize titleExpectedLabelSize;
    CGFloat titleNewHeight;
    CGSize titleConstraintSize = CGSizeMake(245.0f, 999.0f);
    
    NSString* cell_title = [NSString stringWithFormat:@"%@ %@:",comment.user.username, NSLocalizedString(@"dijo", @"dijo")];
    
    titleExpectedLabelSize = [cell_title boundingRectWithSize:titleConstraintSize
                                                      options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:stringAttributes context:nil].size;
    titleNewHeight = titleExpectedLabelSize.height;
    //titleNewHeight += 5;
    
    CGRect  titleFrame_aux = titleFrame;
    titleFrame_aux.size.height = titleNewHeight;
    titleFrame = titleFrame_aux;
    
    /* comment and date*/
    UIFont* commentFont = [UIFont systemFontOfSize:14];
    stringAttributes = [NSDictionary dictionaryWithObject:commentFont forKey: NSFontAttributeName];
    
    CGSize commentExpectedLabelSize;
    CGFloat commentNewHeight;
    CGSize commentConstraintSize = CGSizeMake(245.0f, 999.0);
    commentExpectedLabelSize = [comment.text boundingRectWithSize:commentConstraintSize
                                                          options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:stringAttributes context:nil].size;
    commentNewHeight = commentExpectedLabelSize.height;
    commentNewHeight += 10;
    
    
    CGRect commentFrame_aux = commentFrame;
    commentFrame_aux.origin.y = titleFrame.origin.y + titleFrame.size.height;
    commentFrame_aux.size.height = commentNewHeight;
    commentFrame = commentFrame_aux;
    
    return commentFrame.origin.y + commentFrame.size.height;
}

- (CGFloat)getCommentCellHeight2:(Comment *)comment
{
    //CGRect titleFrame = CGRectMake(55.0, 8.0, 245.0, 21.0);
    //CGRect commentFrame = CGRectMake(55.0, 27.0, 245.0, 21.0);
    
    CGRect titleFrame = CGRectMake(20.0, 8.0, 245.0, 21.0);
    CGRect commentFrame = CGRectMake(20.0, 27.0, 245.0, 21.0);
    
    UIFont* titleFont = [UIFont boldSystemFontOfSize:16.0];
    NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:titleFont forKey: NSFontAttributeName];
    
    /* title */
    CGSize titleExpectedLabelSize;
    CGFloat titleNewHeight;
    CGSize titleConstraintSize = CGSizeMake(245.0f, 999.0f);
    
    NSString* cell_title = [NSString stringWithFormat:@"%@ %@:",comment.user.username, NSLocalizedString(@"dijo", @"dijo")];
    
    titleExpectedLabelSize = [cell_title boundingRectWithSize:titleConstraintSize
                                                      options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:stringAttributes context:nil].size;
    titleNewHeight = titleExpectedLabelSize.height;
    //titleNewHeight += 5;
    
    CGRect  titleFrame_aux = titleFrame;
    titleFrame_aux.size.height = titleNewHeight;
    titleFrame = titleFrame_aux;
    
    /* comment and date*/
    UIFont* commentFont = [UIFont systemFontOfSize:14];
    stringAttributes = [NSDictionary dictionaryWithObject:commentFont forKey: NSFontAttributeName];
    
    CGSize commentExpectedLabelSize;
    CGFloat commentNewHeight;
    CGSize commentConstraintSize = CGSizeMake(245.0f, 999.0);
    commentExpectedLabelSize = [comment.text boundingRectWithSize:commentConstraintSize
                                                          options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:stringAttributes context:nil].size;
    commentNewHeight = commentExpectedLabelSize.height;
    commentNewHeight += 10;
    
    
    CGRect commentFrame_aux = commentFrame;
    commentFrame_aux.origin.y = titleFrame.origin.y + titleFrame.size.height;
    commentFrame_aux.size.height = commentNewHeight;
    commentFrame = commentFrame_aux;
    
    return commentFrame.origin.y + commentFrame.size.height;
}

#pragma mark -
#pragma mark UIActionSheetDelegate implementation

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:NSLocalizedString(@"Share on Facebook", @"Share on Facebook")]){
        //[[[UIAlertView alloc] initWithTitle:nil message:@"Facebook share" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }else if  ([buttonTitle isEqualToString:NSLocalizedString(@"Share on Twitter", @"Share on Twitter")]){
        //[[[UIAlertView alloc] initWithTitle:nil message:@"Twitter share" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }else if  ([buttonTitle isEqualToString:NSLocalizedString(@"Share on Mail",@"Share on Mail")]){
        //[[[UIAlertView alloc] initWithTitle:nil message:@"Mail share" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

#pragma mark -
#pragma mark HPGrowingTextViewDelegate methods

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
	CGRect r = containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
	containerView.frame = r;
    
    CGRect tableFrame = self.tableView.frame;
    tableFrame.size.height = containerView.frame.origin.y - tableFrame.origin.y;
    self.tableView.frame = tableFrame;
}

#pragma mark -
#pragma mark SLParallaxController methods

-(void) openShutter{
    
    if (keyboardIsShowed) return;
    
    [super openShutter];
    
    [UIView animateWithDuration:0.2
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect containerViewFrame = containerView.frame;
                         containerViewFrame.origin.y = self.view.frame.size.height;
                         containerView.frame = containerViewFrame;
                         
                     }
                     completion:^(BOOL finished){
                         //[self resignTextView];
                     }];
}

// Move UP the tableView to get its original position
-(void) closeShutter{
    [super closeShutter];
    [UIView animateWithDuration:0.2
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect containerViewFrame = containerView.frame;
                         containerViewFrame.origin.y = self.view.frame.size.height - containerViewFrame.size.height;
                         containerView.frame = containerViewFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

#pragma mark -
#pragma mark AlertViewDelegate methods

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:NSLocalizedString(@"Ok", @"Ok")]) {
        [self performSegueWithIdentifier:@"toLoginSegue" sender:nil];
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

#pragma mark -
#pragma mark DetailDelegate methods

- (void) photoTouched:(int)idx
{
    keyboardIsShowed = NO;
    [textView resignFirstResponder];
    
    // imagenes:
    //
    NSMutableArray* images = [NSMutableArray arrayWithCapacity:0];
    for (NSString* image_name in self.complaint.attachs) {
        NSString* urlString = [NSString stringWithFormat:@"%@%@%@",API_BASE_URL,API_UPLOADS,image_name];
        FSBasicImage *photo = [[FSBasicImage alloc] initWithImageURL:[NSURL URLWithString:urlString] name:nil];
        [images addObject:photo];
    }
    
    FSBasicImageSource *photoSource = [[FSBasicImageSource alloc] initWithImages:images];
    FSImageViewerViewController *imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:photoSource];
    [imageViewController setSharingDisabled:YES];
    [self.navigationController pushViewController:imageViewController animated:YES];
}

- (void) affectedAction:(id)sender
{
    keyboardIsShowed = NO;
    [textView resignFirstResponder];
    
    if (![UserHelper getUserToken]) {
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Para poder realizar esta accion debe estar logueado.", @"Para poder realizar esta accion debe estar logueado.") delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        return;
    }
    
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:1] forKey:@"afectados"];
    [params setObject:self.complaint.complaint_id forKey:@"id"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = NSLocalizedString(@"Enviando...", @"Enviando...");
    
    [NetworkManager sendAffectedWithParams:params token:[UserHelper getUserToken] completition:^(NSDictionary *data, NSError *error, NSString *error_message) {
        
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        if (error) {
            [[[UIAlertView alloc] initWithTitle:nil message:error_message delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        }else{
            NSString* response = [data objectForKey:@"res"];
            if ([response isEqualToString:SIGN_UP_OK]) {
                affected++;
                [self.tableView reloadData];
            }
        }
        
    }];
}

- (void) isTrueAction:(id)sender
{
    keyboardIsShowed = NO;
    [textView resignFirstResponder];
    
    if (![UserHelper getUserToken]) {
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Para poder realizar esta accion debe estar logueado.", @"Para poder realizar esta accion debe estar logueado.") delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        return;
    }
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:1] forKey:@"escierto"];
    [params setObject:self.complaint.complaint_id forKey:@"id"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = NSLocalizedString(@"Enviando...", @"Enviando...");
    
    [NetworkManager sendIsTrueWithParams:params token:[UserHelper getUserToken] completition:^(NSDictionary *data, NSError *error, NSString *error_message) {
        
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        if (error) {
            [[[UIAlertView alloc] initWithTitle:nil message:error_message delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        }else{
            NSString* response = [data objectForKey:@"res"];
            if ([response isEqualToString:SIGN_UP_OK]) {
                isTrue++;
                [self.tableView reloadData];
            }
        }
    }];
}

- (void) isNotTrueAction:(id)sender
{
    keyboardIsShowed = NO;
    [textView resignFirstResponder];
    
    if (![UserHelper getUserToken]) {
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Para poder realizar esta accion debe estar logueado.", @"Para poder realizar esta accion debe estar logueado.") delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        return;
    }
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:1] forKey:@"nocierto"];
    [params setObject:self.complaint.complaint_id forKey:@"id"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = NSLocalizedString(@"Enviando...", @"Enviando...");
    
    [NetworkManager sendIsNotTrueWithParams:params token:[UserHelper getUserToken] completition:^(NSDictionary *data, NSError *error, NSString *error_message) {
        
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        if (error) {
            [[[UIAlertView alloc] initWithTitle:nil message:error_message delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") otherButtonTitles:nil] show];
        }else{
            NSString* response = [data objectForKey:@"res"];
            if ([response isEqualToString:SIGN_UP_OK]) {
                isNotTrue++;
                [self.tableView reloadData];
            }
        }
        
    }];
}

@end
