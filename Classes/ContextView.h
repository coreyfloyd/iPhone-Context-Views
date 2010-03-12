//
//  ContextView.h
//  A context view that displays a title and text
//
//  Created by Corey Floyd on 3/15/09.
//  Copyright 2009 Flying Jalapeño Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContextViewActions.h"

@protocol ContextViewDelegate;
@protocol ContextViewDataSource;

@interface ContextView : UIView <ContextViewActions> {

	UIView* mySuperView;
	CGPoint contextViewOrigin;
	CGFloat contextViewWidth;
	
	UILabel* title;
	UILabel* body;
	
	id<ContextViewDataSource> datasource;
	id<ContextViewDelegate> delegate;
	
}
@property(nonatomic,retain)IBOutlet UIView *mySuperView;
@property(nonatomic,assign)CGPoint contextViewOrigin;
@property(nonatomic,assign)CGFloat contextViewWidth;
@property(nonatomic,retain)IBOutlet UILabel *title;
@property(nonatomic,retain)IBOutlet UILabel *body;
@property(nonatomic,retain)id<ContextViewDataSource> datasource;
@property(nonatomic,assign)id<ContextViewDelegate> delegate;

- (id)initInView:(UIView *)aView dataSource:(id<ContextViewDataSource>)dataSource origin:(CGPoint)point width:(CGFloat)width;

@end


@protocol ContextViewDataSource <NSObject>

@optional
- (NSString*)contextViewTitle;
- (NSString*)contextViewBody;

@end
