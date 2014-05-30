//
//  CategoryCell.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 29/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCell : UITableViewCell
{
    __weak IBOutlet UILabel* cell_title;
}

- (void) populateCell:(NSString*)title;

@end
