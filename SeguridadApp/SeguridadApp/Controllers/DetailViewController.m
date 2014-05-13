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
#import "Complaint.h"

#define SECTIONS    3

@interface DetailViewController ()
{
    NSArray* data;
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
    
    [self setupInterface];
    
    NSLog(@"imagenes: %i", self.complaint.pictures.count);
    
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
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
    }else{
        static NSString* identifier = @"DetailFeelingCell";
        DetailFeelingCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"DetailFeelingCell" bundle:nil] forCellReuseIdentifier:identifier];
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell populateCellWithAffected:24 isTrue:3 isntTrue:10];
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
    }
    return height;
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
