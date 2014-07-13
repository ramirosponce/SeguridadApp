//
//  ComplaintCell.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 06/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBFlatButton.h"

@class Complaint;

@interface ComplaintCell : UITableViewCell
{
    __weak IBOutlet UILabel* complaint_title;
    __weak IBOutlet UILabel* complaint_distance;
    __weak IBOutlet UILabel* complaint_description;
    
    __weak IBOutlet UILabel* complaint_date;
    
    __weak IBOutlet UIImageView* complaint_picture;
    __weak IBOutlet UIImageView* video_play_icon;
    
    __weak IBOutlet UILabel* complaint_isTrue;
    __weak IBOutlet UILabel* complaint_isntTrue;
    __weak IBOutlet UILabel* complaint_affected;

    __weak IBOutlet GBFlatButton* affectedNumber;
    __weak IBOutlet GBFlatButton* isTrueNumber;
    __weak IBOutlet GBFlatButton* isntTrueNumber;
    
    __weak IBOutlet GBFlatButton* affectedTitle;
    __weak IBOutlet GBFlatButton* isTrueTitle;
    __weak IBOutlet GBFlatButton* isntTrueTitle;
    
    __weak IBOutlet UIView* photoBG1;
    __weak IBOutlet UIView* photoBG2;
    __weak IBOutlet UIView* photoBG3;
    
    __weak IBOutlet UIActivityIndicatorView* indicator;
}

- (void) populateCell:(Complaint*)complaint;
@end
