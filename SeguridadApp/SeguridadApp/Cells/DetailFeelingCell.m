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
    
    affectedNumber.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    isTrueNumber.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    isntTrueNumber.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
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
    
    [affectedNumber.titleLabel setText:[NSString stringWithFormat:@"%i",affected]];
    [isTrueNumber.titleLabel setText:[NSString stringWithFormat:@"%i",isTrue]];
    [isntTrueNumber.titleLabel setText:[NSString stringWithFormat:@"%i",isntTrue]];
    
    [affectedTitle.titleLabel setText:NSLocalizedString(@"Me afecta", @"Me afecta")];
    [isTrueTitle.titleLabel setText:NSLocalizedString(@"Es cierto", @"Es cierto")];
    [isntTrueTitle.titleLabel setText:NSLocalizedString(@"No es cierto", @"No es cierto")];
    
}

@end
