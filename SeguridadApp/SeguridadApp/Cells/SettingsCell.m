//
//  SettingsCell.m
//  SeguridadApp
//
//  Created by juan felippo on 09/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "SettingsCell.h"

@implementation SettingsCell

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
- (void) populateCell:(NSString*)title
{
    [cell_title setTextColor:[UIColor grayColor]];
    cell_title.Text=title;
}

@end
