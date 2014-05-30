//
//  SelectRegionViewController.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 29/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComplaintViewController.h"

@interface SelectRegionViewController : UIViewController
{
    __weak IBOutlet UITableView* regionsTableview;
}

@property (nonatomic, assign) id <ComplaintDelegate> delegate;

@end
