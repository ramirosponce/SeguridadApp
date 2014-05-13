//
//  DetailPicturesCell.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPicturesCell : UITableViewCell
{
    __weak IBOutlet UIScrollView* picture_scroller;
}

- (void) populateCell:(NSArray*)images;

@end
