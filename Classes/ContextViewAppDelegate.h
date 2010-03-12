//
//  ContextViewAppDelegate.h
//  ContextView
//
//  Created by Corey Floyd on 3/10/10.
//  Copyright Flying Jalapeño Software 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContextViewViewController;

@interface ContextViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ContextViewViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ContextViewViewController *viewController;

@end

