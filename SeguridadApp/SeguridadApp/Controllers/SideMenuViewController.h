//
//  SideMenuViewController.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 05/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView* menuTableView;
    
    __weak IBOutlet UIView* profile_view;
    __weak IBOutlet UIImageView* avatar_imageView;
    __weak IBOutlet UILabel* profile_name;
    __weak IBOutlet UILabel* profile_legend;
    
}
@end
