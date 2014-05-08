//
//  ComplaintCell.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 06/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Complaint;

@interface ComplaintCell : UITableViewCell
{
    __weak IBOutlet UILabel* complaint_title;
    __weak IBOutlet UILabel* complaint_distance;
    __weak IBOutlet UILabel* complaint_description;
    
    __weak IBOutlet UILabel* complaint_date;
    __weak IBOutlet UIImageView* complaint_picture;
    __weak IBOutlet UILabel* complaint_isTrue;
    __weak IBOutlet UILabel* complaint_isntTrue;
    __weak IBOutlet UILabel* complaint_affected;
}

- (void) populateCell:(Complaint*)complaint;
@end
