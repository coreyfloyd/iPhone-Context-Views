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
	
	NSArray* optionNames;
	
	id<ContextMenuViewDataSource> datasource;
	id<ContextMenuViewDelegate, ContextViewDelegate> delegate;
	
}
@property(nonatomic,retain)IBOutlet UIView *mySuperView;
@property(nonatomic,assign)CGPoint contextViewOrigin;
@property(nonatomic,assign)CGFloat contextViewWidth;
@property(nonatomic,retain)NSArray *optionNames;
@property(nonatomic,assign)id<ContextMenuViewDelegate, ContextViewDelegate> delegate;
@property(nonatomic,retain)id<ContextMenuViewDataSource> datasource;


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


