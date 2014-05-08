//
//  FiltersViewController.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 08/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "FiltersViewController.h"
#import "TimeFilterCell.h"
#import "CategoryFilterCell.h"
#import "DataHelper.h"
#import "CategoryFilter.h"

#define K_FILTERS_SECTIONS      2

@interface FiltersViewController ()

{
    NSArray* timeData;
    NSMutableArray* categoryData;
}

@end

@implementation FiltersViewController

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
    
    timeData = [[NSArray alloc] initWithArray:[DataHelper getTimeFilterData]];
    
    
    
    
    
    categoryData = [[NSMutableArray alloc] initWithCapacity:0];
    [categoryData addObject:[[CategoryFilter alloc] initWithData:@{@"id": @"-1",@"name": NSLocalizedString(@"All", @"All")}]];
    [categoryData addObjectsFromArray:[DataHelper getCategoryFilterData]];
    
    [self setupInterface];
}

- (void) loadCategories
{
    NSMutableArray* categories_temp = [NSMutableArray arrayWithCapacity:0];
    
    // chequeamos si hay algun filtro seleccionado, y almacenamos el resultado en una
    // variable booleana
    BOOL isCategoryFiltersEmpty = YES;
    if ([[GlobalManager sharedManager] areCategoryFilters]) {
        isCategoryFiltersEmpty = NO;
    }
    
    NSArray* categories = [DataHelper getTimeFilterData];
    for (CategoryFilter* category in categories) {
        if (isCategoryFiltersEmpty) {
            category.isSelected = YES;
            [[GlobalManager sharedManager].category_filters addObject:category];
        }else{
            if ([[GlobalManager sharedManager] isCategorySelected:category.category_id]) {
                category.isSelected = YES;
            }else
                category.isSelected = NO;
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (void) setupInterface
{
    
    self.title = NSLocalizedString(@"Filters", @"Filters");
    [filtersTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

#pragma mark - 
#pragma mark Actions

#pragma mark -
#pragma mark UITableView methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return K_FILTERS_SECTIONS;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    float height = 0.0;
    if (section == 0)
        height = 44.0f;
    else
        height = 50.0f;
    return height;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 42)];
    [header setBackgroundColor:tableView.backgroundColor];
    
    
    UIView* title_bg_view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 10.0, 320.0, 35.0)];
    [title_bg_view setBackgroundColor:[UIColor whiteColor]];
    [header addSubview:title_bg_view];
    
    
    UIView* divider = [[UIView alloc] initWithFrame:CGRectMake(0.0, 35.0, 320.0, 1.0)];
    [divider setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]];
    [title_bg_view addSubview:divider];
    
    //UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(11.0, 9.0, 289.0, 21.0)];
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 21.0)];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setFont:[UIFont systemFontOfSize:15]];
    [title setTextColor:[UIColor grayColor]];
    [title setTextColor:UIColorFromRGB(0x007AFF)];
    [title_bg_view addSubview:title];
    
    if (section == 0){
        [title setText:NSLocalizedString(@"Show Result by", @"Show Result by")];
    }else
        [title setText:NSLocalizedString(@"Categories", @"Categories")];
    
    return header;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return [timeData count];
    else
        return [categoryData count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // set up the cell
    if (indexPath.section == 0) {
        
        static  NSString* CellIdentifier = @"TimeFilterCell";
        TimeFilterCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = (TimeFilterCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        NSDictionary* time_data = [timeData objectAtIndex:indexPath.row];
        
        BOOL isSelected = NO;
        if (indexPath.row == [GlobalManager sharedManager].datefilterType) {
            isSelected = YES;
        }
        
        [cell populateCell:[time_data objectForKey:@"title"] isSelected:isSelected];
        
        return cell;
    }else {
        static  NSString* CellIdentifier = @"CategoryFilterCell";
        CategoryFilterCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = (CategoryFilterCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        CategoryFilter* category = [categoryData objectAtIndex:indexPath.row];
        [cell populateCell:category.name isSelected:category.isSelected];
        
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // set up the cell
    if (indexPath.section == 0) {
        
        [GlobalManager sharedManager].datefilterType = indexPath.row;
        [filtersTableView reloadData];
    }else{
        
    }
}

@end
