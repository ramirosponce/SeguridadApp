//
//  CategoryCell.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 29/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) populateCell:(NSString*)title isSelected:(BOOL)selected
{
    [cell_title setTextColor:[UIColor grayColor]];
    cell_title.text = title;
    
    cell_check_selected.hidden = !selected;
    
}

@end
