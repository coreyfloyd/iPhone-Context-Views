//
//  ContextViewViewController.h
//  ContextView
//
//  Created by Corey Floyd on 3/10/10.
//  Copyright Flying Jalapeño Software 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContextView.h"
#import "ContextMenuView.h"
@class MyDummyClass;

@interface ContextViewViewController : UIViewController <ContextMenuViewDelegate, ContextViewDelegate> {

	
	MyDummyClass* myDummyObject;
}
@property(nonatomic,retain)MyDummyClass *myDummyObject;

- (void)displayContextMenuAtPoint:(CGPoint)point;
- (void)displayContextViewAtPoint:(CGPoint)point;
- (void)setRandomBackgroundColor;

@end

