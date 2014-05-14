//
//  DetailCommentCell.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 14/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "DetailCommentCell.h"
#import "UIImageView+WebCache.h"

@implementation DetailCommentCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) populateCell:(Comment*)comment
{
    cell_title.text = [NSString stringWithFormat:@"%@ %@:",comment.user.username, NSLocalizedString(@"dijo", @"dijo")];
    [profile_picture setClipsToBounds:YES];
    [profile_picture.layer setCornerRadius:(float)(profile_picture.frame.size.width/2)];
    //[profile_picture setImage:[UIImage imageNamed:comment.user.profile_image_name]];
    
    [profile_picture setImageWithURL:nil placeholderImage:[UIImage imageNamed:comment.user.profile_image_name]];
    
    cell_comment.text = comment.text;
    
    [self makeDynamicContent];
}

- (void) makeDynamicContent
{
    //UIFont* font = [UIFont fontWithName:@"Nombre de la fuente" size:@"tamaño de la fuente"];
    //NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:font forKey: NSFontAttributeName];
    
    UIFont* titleFont = cell_title.font;
    NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:titleFont forKey: NSFontAttributeName];
    
    /* title */
    CGSize titleExpectedLabelSize;
    CGFloat titleNewHeight;
    CGSize titleConstraintSize = CGSizeMake(245.0f, 999.0f);
    titleExpectedLabelSize = [cell_title.text boundingRectWithSize:titleConstraintSize
                                                       options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:stringAttributes context:nil].size;
    titleNewHeight = titleExpectedLabelSize.height;
    //titleNewHeight += 5;
    
    CGRect  titleFrame = cell_title.frame;
    titleFrame.size.height = titleNewHeight;
    cell_title.frame = titleFrame;
    
    
    /* comment and date*/
    UIFont* commentFont = cell_comment.font;
    stringAttributes = [NSDictionary dictionaryWithObject:commentFont forKey: NSFontAttributeName];
    
    CGSize commentExpectedLabelSize;
    CGFloat commentNewHeight;
    CGSize commentConstraintSize = CGSizeMake(245.0f, 999.0);
    commentExpectedLabelSize = [cell_comment.text boundingRectWithSize:commentConstraintSize
                                                               options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                                            attributes:stringAttributes context:nil].size;
    commentNewHeight = commentExpectedLabelSize.height;
    commentNewHeight += 10;
    
    
    CGRect commentFrame = cell_comment.frame;
    commentFrame.origin.y = cell_title.frame.origin.y + cell_title.frame.size.height - 5;
    commentFrame.size.height = commentNewHeight;
    cell_comment.frame = commentFrame;
    
}

@end
