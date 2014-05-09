//
//  SettingsCell.h
//  SeguridadApp
//
//  Created by juan felippo on 09/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsCell : UITableViewCell
{
    __weak IBOutlet UILabel* cell_title;
    __weak IBOutlet UIImageView* cell_image;
}
- (void) populateCell:(NSString*)title;
@end
