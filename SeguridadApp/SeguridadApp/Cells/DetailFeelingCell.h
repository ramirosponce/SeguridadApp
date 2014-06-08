//
//  DetailFeelingCell.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 13/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBFlatButton.h"
#import "DetailViewController.h"

@interface DetailFeelingCell : UITableViewCell
{
    __weak IBOutlet GBFlatButton* affectedNumber;
    __weak IBOutlet GBFlatButton* isTrueNumber;
    __weak IBOutlet GBFlatButton* isntTrueNumber;
    
    __weak IBOutlet GBFlatButton* affectedTitle;
    __weak IBOutlet GBFlatButton* isTrueTitle;
    __weak IBOutlet GBFlatButton* isntTrueTitle;
}

@property (nonatomic, assign) id <DetailDelegate> delegate;

- (void) populateCellWithAffected:(int)affected isTrue:(int)isTrue isntTrue:(int)isntTrue;

- (IBAction)affectedAction:(id)sender;
- (IBAction)isTrueAction:(id)sender;
- (IBAction)isNotTrueAction:(id)sender;

@end
