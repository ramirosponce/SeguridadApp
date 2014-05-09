//
//  SuggestionViewController.m
//  SeguridadApp
//
//  Created by juan felippo on 09/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "SuggestionViewController.h"

@interface SuggestionViewController ()

@end

@implementation SuggestionViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark private methods

- (void) setupInterface
{
    [commentView setClipsToBounds:YES];
    [commentView.layer setCornerRadius:(float)5.0];
    commentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    commentView.layer.borderWidth = 0.5f;
    NSString* textForTitle= [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Do you have any suggestion?", @"Do you have any suggestion?"),NSLocalizedString(@"Help us to improve", @"Help us to improve")];
    suggestionText.text = textForTitle;
    commentPlaceholder.text = NSLocalizedString(@"Add suggestion", @"Add suggestion");
    [suggestLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer* suggestLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(suggestLabelAction:)];
    [suggestLabelGesture setNumberOfTapsRequired:1];
    [suggestLabel addGestureRecognizer:suggestLabelGesture];
    
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
#pragma mark Action methods

- (void) suggestLabelAction:(UITapGestureRecognizer*) tapGesture
{
    [[[UIAlertView alloc] initWithTitle:nil message:@"suggest button action" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}


@end
