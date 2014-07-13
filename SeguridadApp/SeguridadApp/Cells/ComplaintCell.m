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
#import <AVFoundation/AVFoundation.h>

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
        photoBG1.hidden = NO;
        titleFrame.size.width = LABEL_FRAME_WITH_IMAGE;
        descriptionFrame.size.width = LABEL_FRAME_WITH_IMAGE;
        
        NSString* image_named = [complaint.attachs objectAtIndex:0];
        [complaint_picture setImage:[UIImage imageNamed:image_named]];
        
        NSURL* image_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_BASE_URL,API_UPLOADS,image_named]];
        NSString *urlPath = [image_url path];
        NSArray* components = [[urlPath lastPathComponent] componentsSeparatedByString:@"."];
        
        if ([[components objectAtIndex:1] isEqualToString:@"mov"]){
            //[complaint_picture setImage:[self getVideoThumb:image_url]];
            [complaint_picture setImage:[UIImage imageNamed:@"Icon-72.png"]];
            video_play_icon.hidden = NO;
            [indicator stopAnimating];
        }else{
            video_play_icon.hidden = YES;
            [complaint_picture setImageWithURL:image_url
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                         [indicator stopAnimating];
                                     }];
        }
        
    }else{
        [indicator stopAnimating];
        titleFrame.size.width = LABEL_FRAME_WITHOUT_IMAGE;
        descriptionFrame.size.width = LABEL_FRAME_WITHOUT_IMAGE;
        complaint_picture.image = nil;
        photoBG1.hidden = YES;
        video_play_icon.hidden = YES;
    }
    
    complaint_title.frame = titleFrame;
    complaint_description.frame = descriptionFrame;
    
    
    complaint_title.text = complaint.complaint_title;
    complaint_description.text = complaint.complaint_description;
    
    if (complaint.frecuentemente) {
        complaint_date.text = NSLocalizedString(@"Esto sucede frecuentemente", @"Esto sucede frecuentemente");
    }else{
        
        if (complaint.complaint_date != nil && complaint.hora != nil) {
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
            NSDate* date = [dateFormatter dateFromString:complaint.complaint_date];
            [dateFormatter setDateFormat:@"dd/MM/yyyy"];
            complaint_date.text = [NSString stringWithFormat:@"%@ - %@", [dateFormatter stringFromDate:date], complaint.hora];
        }else{
            complaint_date.text = @"";
        }
    }
    
    
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

- (UIImage*)getVideoThumb:(NSURL*)vidURL{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:vidURL options:nil];
    AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 60);
    CGImageRef imgRef = [generate copyCGImageAtTime:time actualTime:NULL error:&err];
    NSLog(@"err==%@, imageRef==%@", err, imgRef);
    
    return [[UIImage alloc] initWithCGImage:imgRef scale:(CGFloat)1.0 orientation:UIImageOrientationRight];
    
}

@end
