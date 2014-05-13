//
//  DetailComplaintCell.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "DetailComplaintCell.h"
#import "Complaint.h"

@implementation DetailComplaintCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) populateCell:(Complaint*)complaint
{
    cell_title.text = complaint.complaint_title;
    cell_description.text = complaint.complaint_description;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy hh:mm";
    cell_date.text = [dateFormatter stringFromDate:complaint.complaint_date];
    
    [cell_description setClipsToBounds:YES];
    [cell_description.layer setCornerRadius:(float)5.0];
    cell_description.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    cell_description.layer.borderWidth = 0.5f;
    
}

@end
