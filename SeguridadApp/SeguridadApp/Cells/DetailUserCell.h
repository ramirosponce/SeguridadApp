//
//  DetailUserCell.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 13/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface DetailUserCell : UITableViewCell
{
    __weak IBOutlet UIImageView* profile_picture;
    __weak IBOutlet UILabel* extraLabel;
    __weak IBOutlet UILabel* usernameLabel;
    __weak IBOutlet UILabel* anonymousLabel;
    
}

- (void) populateCell:(User*)user isAnonymous:(BOOL)isAnonymous;

@end
