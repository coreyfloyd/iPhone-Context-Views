//
//  ContextViewProtocol.h
//  Protocols that define how to interact with a context view and provides some delegate hooks
//
//  Created by Corey Floyd on 3/8/10.
//  Copyright 2010 Flying Jalapeño Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContextViewActions <NSObject>

- (void)show;
- (void)dismiss;


@end

@protocol ContextViewDelegate <NSObject>

@optional
- (void)contextViewWasTapped:(id<ContextViewActions>)aContextView;
- (void)contextViewDidDismiss:(id<ContextViewActions>)aContextView;

@end
