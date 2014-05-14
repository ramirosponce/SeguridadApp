//
//  DetailViewController.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 12/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailComplaintCell.h"
#import "DetailPicturesCell.h"
#import "DetailFeelingCell.h"
#import "DetailCommentCell.h"

#import "Complaint.h"
#import "DetailUserCell.h"
#import "Comment.h"
#import "DataHelper.h"

#define SECTIONS    5

@interface DetailViewController ()
{
    NSArray* data;
    NSArray* comments;
    NSMutableArray* commentsHeights;
}
@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedLocation = CLLocationCoordinate2DMake([self.complaint.location.latitude doubleValue],
                                                           [self.complaint.location.longitude doubleValue]);
    
    data = @[@"titulo1",@"titulo2",@"titulo3",@"titulo4",@"titulo5",@"titulo6"];
    comments = [[NSArray alloc] initWithArray:[DataHelper getCommentsData]];
    
    commentsHeights = [[NSMutableArray alloc] initWithCapacity:0];
    for (Comment* comment in comments) {
        CGFloat height = [self getCommentCellHeight2:comment];
        [commentsHeights addObject:[NSNumber numberWithFloat:height]];
    }
    
    
    [self setupInterface];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark private methods

- (void) setupInterface
{
    self.title = NSLocalizedString(@"Detalle", @"Detalle");
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailComplaintCell" bundle:nil] forCellReuseIdentifier:@"DetailComplaintCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailPicturesCell" bundle:nil] forCellReuseIdentifier:@"DetailPicturesCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailFeelingCell" bundle:nil] forCellReuseIdentifier:@"DetailFeelingCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailUserCell" bundle:nil] forCellReuseIdentifier:@"DetailUserCell"];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberOfRows = 0;
    if (section == 4) {
        numberOfRows = [comments count];
    }else{
        numberOfRows = 1;
    }
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"DetailComplaintCell";
        DetailComplaintCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"DetailComplaintCell" bundle:nil] forCellReuseIdentifier:identifier];
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell populateCell:self.complaint];
        return cell;
    }else if (indexPath.section == 1){
        static NSString *identifier = @"DetailPicturesCell";
        DetailPicturesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"DetailPicturesCell" bundle:nil] forCellReuseIdentifier:identifier];
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell populateCell:self.complaint.pictures];
        return cell;
    }else if (indexPath.section == 2){
        static NSString* identifier = @"DetailFeelingCell";
        DetailFeelingCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"DetailFeelingCell" bundle:nil] forCellReuseIdentifier:identifier];
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell populateCellWithAffected:self.complaint.affected isTrue:self.complaint.isTrue isntTrue:self.complaint.isntTrue];
        return cell;
    }else if (indexPath.section == 3){
        
        static NSString* identifier = @"DetailUserCell";
        DetailUserCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"DetailUserCell" bundle:nil] forCellReuseIdentifier:identifier];
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell populateCell:self.complaint.user isAnonymous:self.complaint.isAnonymous];
        return cell;
        
    }else{
        static NSString* identifier = @"DetailCommentCell";
        DetailCommentCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"DetailCommentCell" bundle:nil] forCellReuseIdentifier:identifier];
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        Comment* comment = [comments objectAtIndex:indexPath.row];
        [cell populateCell:comment];
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    switch (indexPath.section) {
        case 0:
            height = 183.0;
            break;
        case 1:
            if (self.complaint.pictures.count > 0) {
                height = 75.0;
            }
            break;
        case 2:
            height = 54.0;
            break;
        case 3:
            height = 60.0;
            if (self.complaint.isAnonymous)
                height = 44.0;
            break;
        case 4:
            //height = [self getCommentCellHeight:indexPath];
            height = [[commentsHeights objectAtIndex:indexPath.row] floatValue];
            break;
    }
    return height;
}

- (CGFloat)getCommentCellHeight:(NSIndexPath *)indexPath
{
    Comment* comment = (Comment*)[comments objectAtIndex:indexPath.row];
    
    CGRect titleFrame = CGRectMake(55.0, 8.0, 245.0, 21.0);
    CGRect commentFrame = CGRectMake(55.0, 27.0, 245.0, 21.0);
    
    UIFont* titleFont = [UIFont boldSystemFontOfSize:16.0];
    NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:titleFont forKey: NSFontAttributeName];
    
    /* title */
    CGSize titleExpectedLabelSize;
    CGFloat titleNewHeight;
    CGSize titleConstraintSize = CGSizeMake(245.0f, 999.0f);
    
    NSString* cell_title = [NSString stringWithFormat:@"%@ %@:",comment.user.username, NSLocalizedString(@"dijo", @"dijo")];
    
    titleExpectedLabelSize = [cell_title boundingRectWithSize:titleConstraintSize
                                                      options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:stringAttributes context:nil].size;
    titleNewHeight = titleExpectedLabelSize.height;
    //titleNewHeight += 5;
    
    CGRect  titleFrame_aux = titleFrame;
    titleFrame_aux.size.height = titleNewHeight;
    titleFrame = titleFrame_aux;
    
    /* comment and date*/
    UIFont* commentFont = [UIFont systemFontOfSize:14];
    stringAttributes = [NSDictionary dictionaryWithObject:commentFont forKey: NSFontAttributeName];
    
    CGSize commentExpectedLabelSize;
    CGFloat commentNewHeight;
    CGSize commentConstraintSize = CGSizeMake(245.0f, 999.0);
    commentExpectedLabelSize = [comment.text boundingRectWithSize:commentConstraintSize
                                                          options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:stringAttributes context:nil].size;
    commentNewHeight = commentExpectedLabelSize.height;
    commentNewHeight += 10;
    
    
    CGRect commentFrame_aux = commentFrame;
    commentFrame_aux.origin.y = titleFrame.origin.y + titleFrame.size.height;
    commentFrame_aux.size.height = commentNewHeight;
    commentFrame = commentFrame_aux;
    
    return commentFrame.origin.y + commentFrame.size.height;
}

- (CGFloat)getCommentCellHeight2:(Comment *)comment
{
    CGRect titleFrame = CGRectMake(55.0, 8.0, 245.0, 21.0);
    CGRect commentFrame = CGRectMake(55.0, 27.0, 245.0, 21.0);
    
    UIFont* titleFont = [UIFont boldSystemFontOfSize:16.0];
    NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:titleFont forKey: NSFontAttributeName];
    
    /* title */
    CGSize titleExpectedLabelSize;
    CGFloat titleNewHeight;
    CGSize titleConstraintSize = CGSizeMake(245.0f, 999.0f);
    
    NSString* cell_title = [NSString stringWithFormat:@"%@ %@:",comment.user.username, NSLocalizedString(@"dijo", @"dijo")];
    
    titleExpectedLabelSize = [cell_title boundingRectWithSize:titleConstraintSize
                                                      options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:stringAttributes context:nil].size;
    titleNewHeight = titleExpectedLabelSize.height;
    //titleNewHeight += 5;
    
    CGRect  titleFrame_aux = titleFrame;
    titleFrame_aux.size.height = titleNewHeight;
    titleFrame = titleFrame_aux;
    
    /* comment and date*/
    UIFont* commentFont = [UIFont systemFontOfSize:14];
    stringAttributes = [NSDictionary dictionaryWithObject:commentFont forKey: NSFontAttributeName];
    
    CGSize commentExpectedLabelSize;
    CGFloat commentNewHeight;
    CGSize commentConstraintSize = CGSizeMake(245.0f, 999.0);
    commentExpectedLabelSize = [comment.text boundingRectWithSize:commentConstraintSize
                                                          options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:stringAttributes context:nil].size;
    commentNewHeight = commentExpectedLabelSize.height;
    commentNewHeight += 10;
    
    
    CGRect commentFrame_aux = commentFrame;
    commentFrame_aux.origin.y = titleFrame.origin.y + titleFrame.size.height;
    commentFrame_aux.size.height = commentNewHeight;
    commentFrame = commentFrame_aux;
    
    return commentFrame.origin.y + commentFrame.size.height;
}

/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestDetail2Cell *cell;
    static NSString *identifier = @"TestDetail2Cell";
    
    if(indexPath.row == 0){
        //identifier = @"firstCell";
        // Add some shadow to the first cell
        cell = (TestDetail2Cell*)[tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell){
            
            cell = (TestDetail2Cell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                            reuseIdentifier:identifier];
            
            CGRect shadowFrame      = cell.layer.bounds;
            CGPathRef shadowPath    = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
            cell.layer.shadowPath   = shadowPath;
            [cell.layer setShadowOffset:CGSizeMake(-2, -2)];
            [cell.layer setShadowColor:[[UIColor grayColor] CGColor]];
            [cell.layer setShadowOpacity:.75];
        }
    }
    else{
        //identifier = @"otherCell";
        cell = (TestDetail2Cell*)[tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell)
            cell = (TestDetail2Cell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                            reuseIdentifier:identifier];
    }
    
    //NSString* title = [data objectAtIndex:indexPath.row];
    //[[cell textLabel] setText:title];
    [cell populateCell:[data objectAtIndex:indexPath.row]];
    return cell;
}*/

@end
