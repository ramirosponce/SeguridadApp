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
    
    if (complaint.frecuentemente) {
        cell_date.text = NSLocalizedString(@"Esto sucede frecuentemente", @"Esto sucede frecuentemente");
    }else{
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        NSDate* date = [dateFormatter dateFromString:complaint.complaint_date];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        //cell_date.text = [dateFormatter stringFromDate:complaint.complaint_date];
        cell_date.text = [NSString stringWithFormat:@"%@ - %@", [dateFormatter stringFromDate:date], complaint.hora];
    }
    
    [cell_description setClipsToBounds:YES];
    [cell_description.layer setCornerRadius:(float)5.0];
    cell_description.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    cell_description.layer.borderWidth = 0.5f;
    
    //top shadow
    
    if (topShadowView == nil) {
        topShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 5)];
        CAGradientLayer *topShadow = [CAGradientLayer layer];
        topShadow.frame = CGRectMake(0, 0, self.bounds.size.width, 5);
        topShadow.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0.0 alpha:0.25f] CGColor], (id)[[UIColor clearColor] CGColor], nil];
        [topShadowView.layer insertSublayer:topShadow atIndex:0];
        
        [self addSubview:topShadowView];
    }
}

@end
