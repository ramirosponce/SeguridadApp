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
}

- (void) populateCell:(NSDictionary*)data isSelected:(BOOL)isSelected;

@end
