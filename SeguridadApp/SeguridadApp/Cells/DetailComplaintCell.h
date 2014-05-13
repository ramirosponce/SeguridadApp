//
//  DetailComplaintCell.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Complaint;

@interface DetailComplaintCell : UITableViewCell
{
    __weak IBOutlet UILabel* cell_title;
    __weak IBOutlet UITextView* cell_description;
    __weak IBOutlet UILabel* cell_date;
}

- (void) populateCell:(Complaint*)complaint;

@end
