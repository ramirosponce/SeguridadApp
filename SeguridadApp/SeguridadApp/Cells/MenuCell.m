//
//  MenuCell.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 06/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

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

- (void) populateCell:(NSDictionary*)data isSelected:(BOOL)isSelected badge:(BOOL)badge badgeCount:(int)badgeCount badgeColor:(UIColor*)badgeColor
{
    NSString* icon_name = [data objectForKey:@"icon_name"];
    [cell_icon setImage:[UIImage imageNamed:icon_name]];
    cell_title.text = [data objectForKey:@"title"];
    
    if (isSelected) {
        //[icon_background setBackgroundColor:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5]];
        [icon_background setBackgroundColor:UIColorFromRGB(0x067AB5)];
    }else{
        [icon_background setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    }
    
    [icon_background setClipsToBounds:YES];
    [icon_background.layer setCornerRadius:(float)(icon_background.frame.size.width/2)];
    [badge_background setClipsToBounds:YES];
    [badge_background.layer setCornerRadius:(float)(badge_background.frame.size.width/2)];
    [badge_background.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [badge_background.layer setBorderWidth:1];
    
    badge_background.hidden = !badge;
    badge_text.hidden = !badge;
    [badge_background setBackgroundColor:badgeColor];
    badge_text.text = [NSString stringWithFormat:@"%i",badgeCount];
    [badge_text setTextColor:[UIColor whiteColor]];
    [badge_text setBackgroundColor:[UIColor clearColor]];
    

}

@end
