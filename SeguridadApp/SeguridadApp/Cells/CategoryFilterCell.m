//
//  CategoryFilterCell.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 08/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "CategoryFilterCell.h"

@implementation CategoryFilterCell

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

    // Configure the view for the selected state
}

- (void) populateCell:(NSString*)title isSelected:(BOOL)isSelected
{
    [cell_title setTextColor:[UIColor grayColor]];
    
    cell_title.text = title;
    if (isSelected) {
        [cell_checkmark setImage:[UIImage imageNamed:@"check_box_on.png"]];
    }else{
        [cell_checkmark setImage:[UIImage imageNamed:@"check_box_off.png"]];
    }
}

@end
