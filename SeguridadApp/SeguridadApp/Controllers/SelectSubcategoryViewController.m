//
//  SelectSubcategoryViewController.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 29/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "SelectSubcategoryViewController.h"
#import "SubcategoryCell.h"
#import "ComplaintType.h"

@interface SelectSubcategoryViewController ()

@end

@implementation SelectSubcategoryViewController

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
    [self setupInteface];
    self.subcategories = [[NSArray alloc] initWithArray:self.category.subcategories];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark private methods

- (void) setupInteface
{
    //self.title = NSLocalizedString(@"Subcategorias", @"Subcategorias");
    self.title = self.category.name;
    
    [subcategoriesTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //UIBarButtonItem* options = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cerrar", @"Cerrar") style:UIBarButtonItemStylePlain target:self action:@selector(closeMenuSelection)];
    //self.navigationItem.leftBarButtonItem = options;
    
}

#pragma mark -
#pragma mark Actions methods

- (void) closeMenuSelection
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark UITableView methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.subcategories count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString* CellIdentifier = @"SubcategoryCell";
    SubcategoryCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (SubcategoryCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    [cell populateCell:[self.subcategories objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.subcategory_selected = [self.subcategories objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didFinishCategorySelection:subcategory:iconname:)]) {
        [self.delegate didFinishCategorySelection:self.category.name subcategory:self.subcategory_selected iconname:self.category.icon_name];
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
