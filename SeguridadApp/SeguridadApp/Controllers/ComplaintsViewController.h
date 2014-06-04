//
//  ComplaintsViewController.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 04/06/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplaintsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView* complaintTableView;
}
@end
