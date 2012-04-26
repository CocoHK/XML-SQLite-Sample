//
//  CustomerDetailViewController.m
//  Demo
//
//  Created by Coco on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EmployeeDetailViewController.h"

@interface EmployeeDetailViewController ()

@end

@implementation EmployeeDetailViewController

@synthesize employee;

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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    switch (indexPath.row) {
        default:
        case 0:
            cell.textLabel.text = @"ID";
            cell.detailTextLabel.text = self.employee.employeeID;
            break;
        case 1:
            cell.textLabel.text = @"Name";
            cell.detailTextLabel.text = self.employee.name;
            break;
        case 2:
            cell.textLabel.text = @"Age";
            cell.detailTextLabel.text = self.employee.age;
            break;
        case 3:
            cell.textLabel.text = @"Address";
            cell.detailTextLabel.text = self.employee.address;
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *message = nil;
    switch (indexPath.row) {
        default:
        case 0:
            message = self.employee.employeeID;
            break;
        case 1:
            message = self.employee.name;
            break;
        case 2:
            message = self.employee.age;
            break;
        case 3:
            message = self.employee.address;
            break;
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

@end
