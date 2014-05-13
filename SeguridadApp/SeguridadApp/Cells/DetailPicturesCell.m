//
//  DetailPicturesCell.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "DetailPicturesCell.h"

#define IMAGE_WIDTH     69.0
#define IMAGE_ORIGIN    72.0

@implementation DetailPicturesCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) populateCell:(NSArray*)images
{
    [picture_scroller setContentSize:CGSizeMake(images.count * IMAGE_ORIGIN, picture_scroller.frame.size.height)];
    
    CGFloat origin_x = 3.0;
    
    for (NSString* image_url in images) {
        
        UIImage* image = [UIImage imageNamed:image_url];
        UIImageView* picture_container = [[UIImageView alloc] initWithFrame:CGRectMake(origin_x, 0.0, IMAGE_WIDTH, IMAGE_WIDTH)];
        [picture_container setImage:image];
        [picture_container setClipsToBounds:YES];
        [picture_container.layer setCornerRadius:(float)5.0];
        [picture_scroller addSubview:picture_container];
        origin_x += IMAGE_ORIGIN;
    }
}

@end
