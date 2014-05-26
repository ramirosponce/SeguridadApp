//
//  ComplaintCell.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 06/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "ComplaintCell.h"
#import "Complaint.h"
#import "UIImageView+WebCache.h"


#define LABEL_FRAME_WITH_IMAGE      202.0
#define LABEL_FRAME_WITHOUT_IMAGE   290.0

@implementation ComplaintCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) populateCell:(Complaint*)complaint
{
    
    CGRect titleFrame = complaint_title.frame;
    CGRect descriptionFrame = complaint_description.frame;
    
    if (complaint.attachs != nil && complaint.attachs.count > 0) {
        
        titleFrame.size.width = LABEL_FRAME_WITH_IMAGE;
        descriptionFrame.size.width = LABEL_FRAME_WITH_IMAGE;
        
        NSString* image_named = [complaint.attachs objectAtIndex:0];
        [complaint_picture setImage:[UIImage imageNamed:image_named]];
        
        NSURL* image_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_BASE_URL,API_UPLOAD,image_named]];
        [complaint_picture setImageWithURL:image_url];
    }else{
        titleFrame.size.width = LABEL_FRAME_WITHOUT_IMAGE;
        descriptionFrame.size.width = LABEL_FRAME_WITHOUT_IMAGE;
        complaint_picture.image = nil;
    }
    
    complaint_title.frame = titleFrame;
    complaint_description.frame = descriptionFrame;
    
    
    complaint_title.text = complaint.complaint_title;
    complaint_distance.text = @"345 mts";
    complaint_description.text = complaint.complaint_description;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    //complaint_date.text = [dateFormatter stringFromDate:complaint.complaint_date];
    
    
    
    complaint_affected.text = [NSString stringWithFormat:@"%i",complaint.affected];
    complaint_isTrue.text = [NSString stringWithFormat:@"%i",complaint.isTrue];
    complaint_isntTrue.text = [NSString stringWithFormat:@"%i",complaint.isntTrue];
    
}

@end
