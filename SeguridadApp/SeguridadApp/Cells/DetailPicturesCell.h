//
//  DetailPicturesCell.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface DetailPicturesCell : UITableViewCell
{
    __weak IBOutlet UIScrollView* picture_scroller;
    NSMutableArray* media_urls;
}

@property (nonatomic, assign) id <DetailDelegate> delegate;

- (void) populateCell:(NSArray*)images;

@end
