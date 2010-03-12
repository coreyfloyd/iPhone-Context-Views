//
//  MyDummyClass.m
//  ContextView
//
//  Created by Corey Floyd on 3/12/10.
//  Copyright 2010 Flying Jalapeño Software. All rights reserved.
//

#import "MyDummyClass.h"


@implementation MyDummyClass

#pragma mark ContextViewDataSource

- (NSString*)contextViewTitle{
	
	return @"This is My Title!";
	
}
- (NSString*)contextViewBody{
	
	return @"Here is some text. Maybe it says something important?";
	
}

#pragma mark ContextMenuViewDataSource

- (NSArray*)contextViewOptions{
	
	return [NSArray arrayWithObjects:@"Option 1", @"Another Option", @"One More…", nil];
	
}


@end
