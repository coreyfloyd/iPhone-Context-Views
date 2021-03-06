//
//  ContextView.m
//  A context view that displays a title and text
//
//  Created by Corey Floyd on 3/15/09.
//  Copyright 2009 Flying Jalapeño Software. All rights reserved.
//

#import "ContextView.h"
#import "UIView-Extensions.h"


@interface ContextView()

@property(nonatomic,assign)UIView *mySuperView;
@property(nonatomic,assign)CGPoint contextViewOrigin;
@property(nonatomic,assign)CGFloat contextViewWidth;
@property(nonatomic,retain)UILabel *title;
@property(nonatomic,retain)UILabel *body;
@property(nonatomic,retain)id<ContextViewDataSource> datasource;

@end

@implementation ContextView

static float kOutlineInset = 2.0;
static float kTextSeperation = 5.0;


@synthesize mySuperView;
@synthesize contextViewOrigin;
@synthesize contextViewWidth;
@synthesize title;
@synthesize body;
@synthesize datasource;
@synthesize delegate;

- (void) dealloc
{
	[title release], title = nil;
	[body release], body = nil;
	[datasource release], datasource = nil;
	mySuperView = nil;
	delegate = nil;
		
	[super dealloc];
}


- (id)initInView:(UIView *)aView dataSource:(id<ContextViewDataSource>)dataSource origin:(CGPoint)point width:(CGFloat)width{
	
	if(![dataSource conformsToProtocol:@protocol(ContextViewDataSource)]){
		[self release];
		return nil;
	}
	if(([dataSource contextViewBody] == nil) && ([dataSource contextViewTitle]==nil)){
		[self release];
		return nil;
	}
	
	
	CGRect titleFrame;
	
	if([dataSource contextViewTitle] != nil){
	
		titleFrame.origin = CGPointMake(kOutlineInset, kOutlineInset);
		titleFrame.size = [[dataSource contextViewTitle] sizeWithFont:[UIFont boldSystemFontOfSize:17] 
													constrainedToSize:CGSizeMake((width - 2*kOutlineInset) , 480)
														lineBreakMode:UILineBreakModeWordWrap];
	}

		
	
	CGRect bodyFrame;
		
	if([dataSource contextViewBody] != nil){

	bodyFrame.origin = CGPointMake(kOutlineInset, (titleFrame.size.height+kTextSeperation+kOutlineInset));
	bodyFrame.size = [[dataSource contextViewBody] sizeWithFont:[UIFont systemFontOfSize:16]
											  constrainedToSize:CGSizeMake((width - 2*kOutlineInset), 480-titleFrame.size.height-kTextSeperation-point.y)
												  lineBreakMode:UILineBreakModeWordWrap];
	}
	
	CGRect myFrame;
	myFrame.origin = point;
	myFrame.size.width = width;
	
	myFrame.size.height = titleFrame.size.height+bodyFrame.size.height+(2*kOutlineInset) + kTextSeperation;  

	
	self = [super initWithFrame:myFrame];
	if (self != nil) {
		
		self.mySuperView = aView;
		self.backgroundColor = [UIColor whiteColor];
		
		self.title = [[[UILabel alloc] initWithFrame:titleFrame] autorelease];
		self.title.text = [dataSource contextViewTitle];
		self.title.numberOfLines = 0;
		self.title.font = [UIFont boldSystemFontOfSize:17];
		[self addSubview:self.title];
		
		self.body = [[[UILabel alloc] initWithFrame:bodyFrame] autorelease];
		self.body.text = [dataSource contextViewBody];
		self.body.font = [UIFont systemFontOfSize:16];
		self.body.numberOfLines = 0;
		[self addSubview:self.body];

	}
	return self;
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	
	if([delegate respondsToSelector:@selector(contextViewWasTapped:)])
		[delegate contextViewWasTapped:self];
}
	 
- (void)show{
	
	[self.mySuperView addSubview:self];

	
}
- (void)dismiss{
	
	[self removeFromSuperview];
}

	 
- (void)drawRect:(CGRect)rect{
	
	if([self respondsToSelector:@selector(strokeRect:color:)])
		[self strokeRect:rect color:[UIColor blackColor]];
	
}

@end
