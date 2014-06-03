//
//  DetailPicturesCell.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "DetailPicturesCell.h"
#import "UIImageView+WebCache.h"

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
    for (id view in picture_scroller.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
        
    }
    
    [picture_scroller setContentSize:CGSizeMake(images.count * IMAGE_ORIGIN, picture_scroller.frame.size.height)];
    
    CGFloat origin_x = 3.0;
    
    for (NSString* image_name in images) {
        
        NSURL* image_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_BASE_URL,API_UPLOADS,image_name]];
        UIImageView* picture_container = [[UIImageView alloc] initWithFrame:CGRectMake(origin_x, 0.0, IMAGE_WIDTH, IMAGE_WIDTH)];
        [picture_container setImageWithURL:image_url];
        [picture_container setClipsToBounds:YES];
        [picture_container.layer setCornerRadius:(float)5.0];
        [picture_scroller addSubview:picture_container];
        origin_x += IMAGE_ORIGIN;
    }
}

@end
