//
//  CustomerListViewController.h
//  Demo
//
//  Created by Coco on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


@interface EmployeeListViewController : UITableViewController {
    NSArray *employeeList;
}
@property (nonatomic, retain) NSArray *employeeList;
- (IBAction)save:(id)sender;
- (IBAction)clean:(id)sender;
@end
