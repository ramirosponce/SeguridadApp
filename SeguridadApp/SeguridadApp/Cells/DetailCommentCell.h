//
//  DetailCommentCell.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 14/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"

@interface DetailCommentCell : UITableViewCell
{
    __weak IBOutlet UILabel* cell_title;
    __weak IBOutlet UILabel* cell_comment;
    __weak IBOutlet UIImageView* profile_picture;
    
}

- (void) populateCell:(Comment*)comment;

@end
