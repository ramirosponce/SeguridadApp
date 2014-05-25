//
//  SignInViewController.h
//  SeguridadApp
//
//  Created by juan felippo on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface SignInViewController : UIViewController <FBLoginViewDelegate>
{
    __weak IBOutlet UIButton* loginNormalButton;
    __weak IBOutlet UIButton* noAccountButton;
    
    __weak IBOutlet FBLoginView* loginFacebook;
}

- (IBAction) loginNormalButton:(id)sender;
- (IBAction) noAccountButton:(id)sender;

@end
