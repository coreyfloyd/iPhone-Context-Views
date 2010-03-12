//
//  ContextMenuView.m
//  A context view that allows menu population and selection
//  Additionally, there is an additionaly delegate method to respond to menu elections
//
//  Created by Corey Floyd on 3/15/09.
//  Copyright 2009 Flying Jalapeño Software. All rights reserved.
//

#import "ContextMenuView.h"
#import "UIView-Extensions.h"

static float kOptionHeight = 30.0;
static float kOutlineInset = 2.0;
static float kMinWidth = 150;
static float kFontSize = 16;

float maxWidthOfStrings(NSArray* strings){
	
	float width = 0;
	
	for (NSString* eachString in strings){
		
		float w = [eachString sizeWithFont:[UIFont boldSystemFontOfSize:kFontSize]].width;
		
		if(w > width)
			width = w;
	}
	
	if(width < kMinWidth)
		width = kMinWidth;
	
	return width;
	
}

@interface ContextMenuView()

- (void)createOptionsWithNames:(NSArray*)options;
- (UIButton*)buttonWithName:(NSString*)name;

@end



@implementation ContextMenuView

@synthesize mySuperView;
@synthesize contextViewOrigin;
@synthesize contextViewWidth;
@synthesize optionNames;
@synthesize delegate;
@synthesize datasource;




- (void) dealloc
{
	self.mySuperView = nil;
	[datasource release], datasource = nil;
	[mySuperView release], mySuperView = nil;
	[optionNames release], optionNames = nil;
	delegate = nil;
	
	[super dealloc];
}

- (id)initInView:(UIView *)aView dataSource:(id<ContextMenuViewDataSource>)dataSource origin:(CGPoint)point maxWidth:(CGFloat)maxWidth{
	
	
	NSArray* opts = [dataSource contextViewOptions];
	
	if(opts == 0){
		[self release];
		return nil;
	}
	float w = maxWidthOfStrings(opts);

	CGRect myFrame;
	myFrame.origin = point;
	myFrame.size.width = MIN(w, maxWidth);
	myFrame.size.height = [opts count]*kOptionHeight + (2*kOutlineInset); 
	
	self = [super initWithFrame:myFrame];
	if (self != nil) {
		
		self.mySuperView = aView;
		self.optionNames = opts;
		self.datasource = dataSource;
		
		self.backgroundColor = [UIColor whiteColor];
		
		[self createOptionsWithNames:self.optionNames];
		
	}
	
	return self;
		
}

- (void)drawRect:(CGRect)rect{
	
	[self strokeRect:rect color:[UIColor blackColor]];

}

- (void)createOptionsWithNames:(NSArray*)options{
	
	CGRect myFrame;
	myFrame.origin = self.bounds.origin;
	myFrame.origin.x+=kOutlineInset;
	myFrame.origin.y+=kOutlineInset;
	myFrame.size.width = self.bounds.size.width - (2*kOutlineInset);
	myFrame.size.height = kOptionHeight; 
	
	UIButton* option;
	int index = 0;
	for(NSString* eachName in options){
	
		option = [self buttonWithName:eachName];
		option.frame = myFrame;
		option.tag = index;
		option.userInteractionEnabled = YES;
		
		[self addSubview:option];
		
		myFrame.origin.y += kOptionHeight;
		index++;
	}
	
}


- (UIButton*)buttonWithName:(NSString*)name{
	
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setBackgroundColor:[UIColor whiteColor]];
	[button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[button setTitle:name forState:UIControlStateNormal];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
	button.titleLabel.textAlignment = UITextAlignmentLeft;
	button.titleLabel.font = [UIFont boldSystemFontOfSize:kFontSize];
	button.userInteractionEnabled = YES;
	return button;
	
}

- (void)buttonPressed:(id)sender{
	
	if([delegate respondsToSelector:@selector(contextViewWasTapped:)])
		[delegate contextViewWasTapped:self];
	
	if([delegate respondsToSelector:@selector(contextMenu:didSelectItemAtIndex:)])
		[delegate contextMenu:self didSelectItemAtIndex:[(UIButton*)sender tag]];
	
}

- (void)show{
	
	[self.mySuperView addSubview:self];
	
}
- (void)dismiss{
	
	[self removeFromSuperview];
}


@end
