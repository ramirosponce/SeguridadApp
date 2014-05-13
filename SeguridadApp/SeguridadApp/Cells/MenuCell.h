//
//  MenuCell.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 06/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell
{
    __weak IBOutlet UIImageView* cell_icon;
    __weak IBOutlet UILabel* cell_title;
    __weak IBOutlet UIView* icon_background;
    __weak IBOutlet UIView* badge_background;
    __weak IBOutlet UILabel* badge_text;
}

- (void) populateCell:(NSDictionary*)data isSelected:(BOOL)isSelected badge:(BOOL)badge badgeCount:(int)badgeCount badgeColor:(UIColor*)badgeColor;

@end
