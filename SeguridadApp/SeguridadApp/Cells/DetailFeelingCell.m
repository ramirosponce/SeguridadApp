//
//  DetailFeelingCell.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 13/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "DetailFeelingCell.h"

@implementation DetailFeelingCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) populateCellWithAffected:(int)affected isTrue:(int)isTrue isntTrue:(int)isntTrue
{
    
    affectedNumber.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    isTrueNumber.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    isntTrueNumber.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    affectedTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    isTrueTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    isntTrueTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    
    [affectedTitle setUserInteractionEnabled:NO];
    [affectedNumber setUserInteractionEnabled:NO];
    [isTrueTitle setUserInteractionEnabled:NO];
    [isTrueNumber setUserInteractionEnabled:NO];
    [isntTrueTitle setUserInteractionEnabled:NO];
    [isntTrueNumber setUserInteractionEnabled:NO];
    
    [affectedTitle setSelected:YES];
    [isTrueTitle setSelected:YES];
    [isntTrueTitle setSelected:YES];
    
    [affectedNumber setTitle:[NSString stringWithFormat:@"%i",affected] forState:UIControlStateNormal];
    [isTrueNumber setTitle:[NSString stringWithFormat:@"%i",isTrue] forState:UIControlStateNormal];
    [isntTrueNumber setTitle:[NSString stringWithFormat:@"%i",isntTrue] forState:UIControlStateNormal];
    
    [affectedTitle setTitle:NSLocalizedString(@"Me afecta", @"Me afecta") forState:UIControlStateNormal];
    [isTrueTitle setTitle:NSLocalizedString(@"Es cierto", @"Es cierto") forState:UIControlStateNormal];
    [isntTrueTitle setTitle:NSLocalizedString(@"No es cierto", @"No es cierto") forState:UIControlStateNormal];
}

@end
