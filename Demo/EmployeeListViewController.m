//
//  CustomerListViewController.m
//  Demo
//
//  Created by Coco on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EmployeeListViewController.h"
#import "EmployeeDetailViewController.h"
#import "SQLiteOperation.h"
#import "MyEmployee.h"

@interface EmployeeListViewController ()

@end

@implementation EmployeeListViewController

@synthesize employeeList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.employeeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    MyEmployee *employee = [self.employeeList objectAtIndex:indexPath.row];
    cell.textLabel.text = employee.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EmployeeDetailViewController *detailViewController = [[EmployeeDetailViewController alloc] init];
    [detailViewController setEmployee:[self.employeeList objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

#pragma mark - Actions

- (IBAction)save:(id)sender {
    // Save the list to the SQLite database
    for (MyEmployee *employee in self.employeeList) {
        [[SQLiteOperation shared] addEmployee:employee];
    }
}

- (IBAction)clean:(id)sender {
    [[SQLiteOperation shared] cleanAllData];
    
    self.employeeList = [NSArray array];
    [self.tableView reloadData];
}

@end
