//
//  AppDelegate.m
//  Demo
//
//  Created by Coco on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    //Display the employee list
    self.window.rootViewController = [[[UINavigationController alloc] initWithRootViewController:[[[MainViewController alloc] init] autorelease]] autorelease];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
