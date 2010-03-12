//
//  ContextViewAppDelegate.m
//  ContextView
//
//  Created by Corey Floyd on 3/10/10.
//  Copyright Flying Jalapeño Software 2010. All rights reserved.
//

#import "ContextViewAppDelegate.h"
#import "ContextViewViewController.h"

@implementation ContextViewAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
