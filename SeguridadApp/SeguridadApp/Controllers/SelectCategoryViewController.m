//
//  SelectCategoryViewController.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 29/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "SelectCategoryViewController.h"
#import "CategoryCell.h"
#import "ComplaintType.h"
#import "SelectSubcategoryViewController.h"

@interface SelectCategoryViewController ()
{
    NSArray* categories;
}
@end

@implementation SelectCategoryViewController

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
    categories = [NSArray  arrayWithArray:[GlobalManager sharedManager].complaint_types];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark private methods

- (void) setupInteface
{
    self.title = NSLocalizedString(@"Categorias", @"Categorias");
    [categoriesTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UIBarButtonItem* options = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cerrar", @"Cerrar") style:UIBarButtonItemStylePlain target:self action:@selector(closeMenuSelection)];
    self.navigationItem.leftBarButtonItem = options;
    
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
    return [categories count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString* CellIdentifier = @"CategoryCell";
    CategoryCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CategoryCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    ComplaintType* category = [categories objectAtIndex:indexPath.row];
    [cell populateCell:category.name];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComplaintType* category = [categories objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"subcategoriesSegue" sender:category];
    
}

#pragma mark -
#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"subcategoriesSegue"]) {
        SelectSubcategoryViewController* vc = [segue destinationViewController];
        vc.delegate = self.delegate;
        
        ComplaintType* category = (ComplaintType*)sender;
        vc.category = category;
        
        //vc.category_selected = category.name;
        //vc.subcategories = category.subcategories;
        
        
    }
}


@end
