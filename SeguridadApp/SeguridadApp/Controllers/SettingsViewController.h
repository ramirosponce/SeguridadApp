//
//  SettingsViewController.h
//  SeguridadApp
//
//  Created by juan felippo on 09/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
  __weak IBOutlet UITableView* settingsTableView;
}
@end
