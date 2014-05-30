//
//  SelectSubcategoryViewController.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 29/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComplaintViewController.h"

@interface SelectSubcategoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView* subcategoriesTableView;
}

@property (nonatomic, strong) NSString* category_selected;
@property (nonatomic, strong) NSString* subcategory_selected;
@property (nonatomic, strong) NSArray* subcategories;

@property (nonatomic, assign) id <ComplaintDelegate> delegate;

@end
