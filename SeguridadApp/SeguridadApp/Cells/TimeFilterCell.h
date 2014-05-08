//
//  TimeFilterCell.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 08/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeFilterCell : UITableViewCell
{
    __weak IBOutlet UILabel* cell_title;
    __weak IBOutlet UIImageView* cell_checkmark;
}

- (void) populateCell:(NSString*)title isSelected:(BOOL)isSelected;

@end
