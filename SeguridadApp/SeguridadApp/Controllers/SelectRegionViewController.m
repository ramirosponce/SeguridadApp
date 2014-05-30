//
//  SelectRegionViewController.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 29/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "SelectRegionViewController.h"
#import "Region.h"
#import "RegionCell.h"

@interface SelectRegionViewController ()
{
    NSMutableArray* regions;
}
@end

@implementation SelectRegionViewController

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
    
    regions = [NSMutableArray arrayWithArray:[GlobalManager sharedManager].regions];
    
    Region* my_position = [[Region alloc] initWithData:@{@"lbl": NSLocalizedString(@"Mi ubicacion", @"Mi ubicacion")}];
    [regions insertObject:my_position atIndex:0];
    
    [self setupInteface];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark private methods

- (void) setupInteface
{
    self.title = NSLocalizedString(@"Regiones", @"Regiones");
    [regionsTableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UIBarButtonItem* options = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cerrar", @"Cerrar") style:UIBarButtonItemStylePlain target:self action:@selector(closeMenuSelection)];
    self.navigationItem.leftBarButtonItem = options;
    
}

#pragma mark -
#pragma mark actions methods

- (void) closeMenuSelection
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark tableview methods

#pragma mark -
#pragma mark UITableView methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [regions count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString* CellIdentifier = @"RegionCell";
    RegionCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (RegionCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    Region* region = [regions objectAtIndex:indexPath.row];
    [cell populateCell:region.region_name];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Region* region = [regions objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didFinishRegionSelection:)]) {
        [self.delegate didFinishRegionSelection:region];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
