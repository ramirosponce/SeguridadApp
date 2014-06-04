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
    
    [complaint_picture setClipsToBounds:YES];
    [complaint_picture.layer setCornerRadius:(float)5.0];
    
    [photoBG1 setClipsToBounds:YES];
    [photoBG1.layer setCornerRadius:(float)5.0];
    
    [photoBG2 setClipsToBounds:YES];
    [photoBG2.layer setCornerRadius:(float)5.0];
    
    [photoBG3 setClipsToBounds:YES];
    [photoBG3.layer setCornerRadius:(float)5.0];
    
    
    [indicator startAnimating];
    
    
    if (complaint.attachs != nil && complaint.attachs.count > 0) {
        
        titleFrame.size.width = LABEL_FRAME_WITH_IMAGE;
        descriptionFrame.size.width = LABEL_FRAME_WITH_IMAGE;
        
        NSString* image_named = [complaint.attachs objectAtIndex:0];
        [complaint_picture setImage:[UIImage imageNamed:image_named]];
        
        NSURL* image_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_BASE_URL,API_UPLOADS,image_named]];
        [complaint_picture setImageWithURL:image_url
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            [indicator stopAnimating];
        }];
    }else{
        [indicator stopAnimating];
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
    
    affectedNumber.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    isTrueNumber.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    isntTrueNumber.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    affectedTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    isTrueTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    isntTrueTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    
    [affectedTitle setUserInteractionEnabled:NO];
    [affectedNumber setUserInteractionEnabled:NO];
    [isTrueTitle setUserInteractionEnabled:NO];
    [isTrueNumber setUserInteractionEnabled:NO];
    [isntTrueTitle setUserInteractionEnabled:NO];
    [isntTrueNumber setUserInteractionEnabled:NO];
    
    [affectedTitle setSelected:YES];
    [isTrueTitle setSelected:YES];
    [isntTrueTitle setSelected:YES];
    
    [affectedNumber setTitle:[NSString stringWithFormat:@"%i",complaint.affected] forState:UIControlStateNormal];
    [isTrueNumber setTitle:[NSString stringWithFormat:@"%i",complaint.isTrue] forState:UIControlStateNormal];
    [isntTrueNumber setTitle:[NSString stringWithFormat:@"%i",complaint.isntTrue] forState:UIControlStateNormal];
    
    [affectedTitle setTitle:NSLocalizedString(@"Me afecta", @"Me afecta") forState:UIControlStateNormal];
    [isTrueTitle setTitle:NSLocalizedString(@"Es cierto", @"Es cierto") forState:UIControlStateNormal];
    [isntTrueTitle setTitle:NSLocalizedString(@"No es cierto", @"No es cierto") forState:UIControlStateNormal];
    
}

@end
