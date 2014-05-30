//
//  SelectCategoryViewController.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 29/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComplaintViewController.h"

@interface SelectCategoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView* categoriesTableView;
}

@property (nonatomic, assign) id <ComplaintDelegate> delegate;

@end
