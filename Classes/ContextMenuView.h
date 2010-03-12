//
//  ContextMenuView.h
//  A context view that allows menu population and selection
//  Additionally, there is an additionaly delegate method to respond to menu elections
//
//  Created by Corey Floyd on 3/15/09.
//  Copyright 2009 Flying Jalapeño Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContextViewActions.h"



@protocol ContextMenuViewDelegate;
@protocol ContextMenuViewDataSource;


@interface ContextMenuView : UIView <ContextViewActions> {

	UIView* mySuperView;
	CGPoint contextViewOrigin;
	CGFloat contextViewWidth;
		
	id<ContextMenuViewDataSource> datasource;
	id<ContextMenuViewDelegate, ContextViewDelegate> delegate;
	
}
@property(nonatomic,assign)id<ContextMenuViewDelegate, ContextViewDelegate> delegate;


- (id)initInView:(UIView *)aView dataSource:(id<ContextMenuViewDataSource>)dataSource origin:(CGPoint)point maxWidth:(CGFloat)maxWidth;

@end

@protocol ContextMenuViewDelegate <NSObject>

@optional
- (void)contextMenu:(ContextMenuView*)menu didSelectItemAtIndex:(NSInteger)index;

@end

@protocol ContextMenuViewDataSource <NSObject>

@optional
- (NSArray*)contextViewOptions;

@end


