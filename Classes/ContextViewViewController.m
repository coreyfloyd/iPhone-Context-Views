//
//  ContextViewViewController.m
//  ContextView
//
//  Created by Corey Floyd on 3/10/10.
//  Copyright Flying Jalapeño Software 2010. All rights reserved.
//

#import "ContextViewViewController.h"
#import "MyDummyClass.h"
#import "ContextViewActions.h"

@implementation ContextViewViewController

@synthesize myDummyObject;


- (void) dealloc
{
	[myDummyObject release], myDummyObject = nil;
	[super dealloc];
}

- (void)viewDidLoad{
	
	self.myDummyObject = [[MyDummyClass alloc] init];
	
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	
	//lets check if a context view is already on screen…
	for(UIView* eachSubView in self.view.subviews){
		
		if([eachSubView conformsToProtocol:@protocol(ContextViewActions)]){
			[(id<ContextViewActions>)eachSubView dismiss];
			return;
		}
	}
	
	//Ok, lets check to see if someone tapped…
	if([[touches anyObject] tapCount] == 1){
		
		if([[touches anyObject] locationInView:self.view].y < 200){
			
			[self displayContextViewAtPoint:[[touches anyObject] locationInView:self.view]];
			
		}else{
			
			[self displayContextMenuAtPoint:[[touches anyObject] locationInView:self.view]];
		}
	}
}

- (void)displayContextMenuAtPoint:(CGPoint)point{
	
	ContextMenuView* menu = [[ContextMenuView alloc] initInView:self.view dataSource:self.myDummyObject origin:point maxWidth:160];
	menu.delegate = self;
	[menu show];
	[menu release];
	
	//Since showing the menu/view adds it to the super view, we can safely release it.
	
}


- (void)displayContextViewAtPoint:(CGPoint)point{
	
	ContextView* context = [[ContextView alloc] initInView:self.view dataSource:self.myDummyObject origin:point width:160];
	context.delegate = self;
	[context show];
	[context release];
	
}


- (void)contextViewWasTapped:(id<ContextViewActions>)aContextView{
	
	//since both menus and views call this delegate method, lets make sure we only dismiss the context views.
	
	if([aContextView isKindOfClass:[ContextView class]])
		[aContextView dismiss];	
}

- (void)contextMenu:(ContextMenuView*)menu didSelectItemAtIndex:(NSInteger)index{

	//Since the menu has only been retained by the superview, dismissing it will deallocate the menu
	
	[menu dismiss];
	[self setRandomBackgroundColor];

}

	
- (void)setRandomBackgroundColor{
	
	NSArray* colors = [NSArray arrayWithObjects:[UIColor redColor],
					   [UIColor blueColor],
					   [UIColor whiteColor],
					   [UIColor yellowColor],
					   [UIColor grayColor],
					   [UIColor greenColor],
					   nil];
	
	int rand = arc4random() % [colors count];
	
	[self.view setBackgroundColor:[colors objectAtIndex:rand]];
	
	
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


@end
