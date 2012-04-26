//
//  MainViewController.m
//  Demo
//
//  Created by Coco on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "SQLiteOperation.h"
#import "XMLDataParser.h"
#import "EmployeeListViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)showEmployeesFromURL:(id)sender {
    EmployeeListViewController *customerListViewController = [[EmployeeListViewController alloc] init];
    
    //Get the employee data
    NSData *xmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.appready.fr/test/people.php"]];
    
    //Parse the employee data
    if (xmlData != nil) {
        XMLDataParser *xmlDataParser = [[XMLDataParser alloc] init];
        NSArray *employeeList = [xmlDataParser employeeListFromXMLData:xmlData];
        
        // Give the list to the main view controller
        [customerListViewController setEmployeeList:employeeList];
        
        [xmlDataParser release];
    }
    
    // Add buttons to the navigation bar
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:customerListViewController action:@selector(save:)];
    customerListViewController.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];
    
    [self.navigationController pushViewController:customerListViewController animated:YES];
    [customerListViewController release];
}

- (IBAction)showEmployeesFromSQLite:(id)sender {
    EmployeeListViewController *customerListViewController = [[EmployeeListViewController alloc] init];
    NSArray *employeeList = [[SQLiteOperation shared] getAllEmployees];
    
    // Give the list to the main view controller
    [customerListViewController setEmployeeList:employeeList];
    
    // Add buttons to the navigation bar
    UIBarButtonItem *cleanButton = [[UIBarButtonItem alloc] initWithTitle:@"Clean" style:UIBarButtonItemStyleBordered target:customerListViewController action:@selector(clean:)];
    customerListViewController.navigationItem.rightBarButtonItem = cleanButton;
    [cleanButton release];
    
    [self.navigationController pushViewController:customerListViewController animated:YES];
    [customerListViewController release];
}

@end
