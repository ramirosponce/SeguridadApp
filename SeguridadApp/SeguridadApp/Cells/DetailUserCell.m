//
//  DetailUserCell.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 13/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "DetailUserCell.h"

@implementation DetailUserCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) populateCell:(User*)user isAnonymous:(BOOL)isAnonymous
{
    if (!user) {
        usernameLabel.hidden = YES;
        profile_picture.hidden = YES;
        extraLabel.hidden = YES;
        anonymousLabel.hidden = NO;
    }else{
        usernameLabel.hidden = NO;
        profile_picture.hidden = NO;
        extraLabel.hidden = NO;
        anonymousLabel.hidden = YES;
        
        usernameLabel.text = [NSString stringWithFormat:@"%@ %@", user.user_first_name, user.user_last_name];
        
        //[profile_picture setClipsToBounds:YES];
        //[profile_picture.layer setCornerRadius:(float)(profile_picture.frame.size.width/2)];
        //[profile_picture setImage:[UIImage imageNamed:user.profile_image_name]];
    }
}

@end
