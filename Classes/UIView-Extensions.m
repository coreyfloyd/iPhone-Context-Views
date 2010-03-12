//
//  UIView-Extensions.m
//  Little utilities, created and poached from all around the internet
//
//  Created by Corey Floyd on 3/15/09.
//  Copyright 2009 Flying Jalapeño Software. All rights reserved.
//

#import "UIView-Extensions.h"

#define degreesToRadians(x) (M_PI * x / 180.0)


CGRect rectExpandedByValue(CGRect rect,  float expandRadius){
    
    rect.size.width += (2*expandRadius);
    rect.size.height += (2*expandRadius);
    
    rect.origin.x -= expandRadius;
    rect.origin.y -= expandRadius;
    
    
    return rect;
    
}


CGRect rectContractedByValue(CGRect rect,  float expandRadius){
    
    rect.size.width -= (2*expandRadius);
    rect.size.height -= (2*expandRadius);
    
    rect.origin.x += expandRadius;
    rect.origin.y += expandRadius;
    
    return rect;    
    
}


@implementation UIView (utility)

- (void)setBackgroundColor:(UIColor*)aColor recursive:(BOOL)flag{
    
    self.backgroundColor = aColor;
	
    if(flag){
        for(UIView* eachSubview in self.subviews){
            [eachSubview setBackgroundColor:aColor recursive:YES];
            
        }
    }
}

@end




@implementation UIView (frame)

-(void)setOrigin:(CGPoint)aPoint{
    
    CGRect newFrame = self.frame;
    newFrame.origin = aPoint;
    self.frame = newFrame;
    
}
-(void)setOriginY:(float)value{
    
    CGRect newFrame = self.frame;
    newFrame.origin.y = value;
    self.frame = newFrame;
    
}
-(void)setOriginX:(float)value{
    
    CGRect newFrame = self.frame;
    newFrame.origin.x = value;
    self.frame = newFrame;
    
}
-(void)setSize:(CGSize)aSize{
    
    CGRect newFrame = self.frame;
    newFrame.size = aSize;
    self.frame = newFrame;
    
    
}
-(void)setSizeWidth:(float)value{
    
    CGRect newFrame = self.frame;
    newFrame.size.width = value;
    self.frame = newFrame;
    
}
-(void)setSizeHeight:(float)value{
    
    CGRect newFrame = self.frame;
    newFrame.size.height = value;
    self.frame = newFrame;
    
}

@end




@implementation UIView (points)

-(CGPoint)bottomCenter{
    
    return CGPointMake(self.bounds.size.width/2, self.bounds.size.height); 
}
-(CGPoint)topCenter{
    
    return CGPointMake(self.bounds.size.width/2, self.bounds.origin.y); 
}
-(CGPoint)leftCenter{
    
    return CGPointMake(self.bounds.origin.x, self.bounds.size.height/2); 
}
-(CGPoint)rightCenter{
    
    return CGPointMake(self.bounds.size.width, self.bounds.size.height/2); 
}
-(CGPoint)upperRightCorner{
    
    return CGPointMake(self.bounds.size.width, self.bounds.origin.y); 
}
-(CGPoint)upperLeftCorner{
        
    return CGPointMake(self.bounds.origin.x, self.bounds.origin.y); 
}
-(CGPoint)lowerLeftCorner{
    
    return CGPointMake(self.bounds.origin.x, self.bounds.size.height); 
}
-(CGPoint)lowerRightCorner{
    
    return CGPointMake(self.bounds.size.width, self.bounds.size.height); 
}



@end





@implementation UIView (animation)


- (void)fadeInWithDelay:(CGFloat)delay duration:(CGFloat)duration{
    
	[UIView beginAnimations:@"fadeIn" context:nil];
	[UIView setAnimationDelay:delay];
	[UIView setAnimationDuration:duration];
	self.alpha=1;
	[UIView commitAnimations];		
	
	
}

- (void)fadeOutWithDelay:(CGFloat)delay duration:(CGFloat)duration{
	
	[UIView beginAnimations:@"fadeOut" context:nil];
	[UIView setAnimationDelay:delay];
	[UIView setAnimationDuration:duration];
	self.alpha=0;
	[UIView commitAnimations];
	
}

- (void)translateToFrame:(CGRect)aFrame delay:(CGFloat)delay duration:(CGFloat)duration{
	
	[UIView beginAnimations:@"slide" context:nil];
	[UIView setAnimationDelay:delay];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	self.frame=aFrame;
	[UIView commitAnimations];
	
}	

-(void)shrinkToSize:(CGSize)aSize withDelay:(CGFloat)delay duration:(CGFloat)duration{
	
	CGRect myNewFrame= self.frame;
	myNewFrame.size=aSize;	
	myNewFrame.origin=CGPointMake(self.frame.origin.x+self.frame.size.width/2-myNewFrame.size.width/2,self.frame.origin.y+self.frame.size.height/2-myNewFrame.size.height/2);
	
	[UIView beginAnimations:@"shrink" context:nil];
	[UIView setAnimationDuration:.5];	
	self.frame=myNewFrame;
	[UIView commitAnimations];	
	
}


- (void)changeColor:(UIColor *)aColor withDelay:(CGFloat)delay duration:(CGFloat)duration{
	
	[UIView beginAnimations:@"changeColor" context:nil];
	[UIView setAnimationDelay:delay];
	[UIView setAnimationDuration:duration];	
	[self setBackgroundColor:[UIColor lightGrayColor]];
	[UIView commitAnimations];
	
}

- (void)rotate:(float)degrees{
	
	CGAffineTransform rotateTransform = self.transform;
	rotateTransform = CGAffineTransformRotate(rotateTransform, degreesToRadians(degrees));
	self.transform = rotateTransform;
    
}


@end

@implementation UIView (introspection)

- (BOOL)hasSubviewOfClass:(Class)aClass{
    
    BOOL containsClass = NO;
    for(UIView *aSubview in self.subviews){
        NSLog(@"%@",[[aSubview class] description]);
        if([aSubview isKindOfClass:aClass]){
            containsClass = YES;
            break;
        } else {
            containsClass = [aSubview hasSubviewOfClass:aClass];
            if(containsClass)
                break;
        }
    }
    return containsClass;
}

- (BOOL)hasSubviewOfClass:(Class)aClass thatContainsPoint:(CGPoint)aPoint{
    
    BOOL touchIsInClass = NO;
    
    for(UIView *subview in self.subviews){
        
        CGPoint convertedPoint = [subview convertPoint:aPoint fromView:[self superview]];
        NSLog(@"%@",[[subview class] description]);
        if(CGRectContainsPoint(subview.frame, convertedPoint)){
            if([subview isKindOfClass:aClass]){
                touchIsInClass = YES;
                break;
            } else {
                touchIsInClass = [subview hasSubviewOfClass:aClass thatContainsPoint:convertedPoint];
                if(touchIsInClass)
                    break;
                
            }
        }
    }
    
    return touchIsInClass;
}


- (UIView*)firstResponder{
    
    UIView *theFirstResponder = nil;
    
    for(UIView *aSubview in self.subviews){
        
        if([aSubview isFirstResponder]){
            theFirstResponder = aSubview;
            break;
        } else{
            if(theFirstResponder = [aSubview firstResponder])
                break;
        }
    }
    
    //if(!theFirstResponder)
    //NSLog(@"responder not found");
    return theFirstResponder;
    
}


@end


static const CGFloat kCornerSize = 5.0;

static CGRect rectStrokeAdjust(CGRect rect)
{
    rect = CGRectIntegral(rect);
    
    rect.origin.x    += 0.5;
    rect.origin.y    += 0.5;
    rect.size.width  -= 1.0;
    rect.size.height -= 1.0;
    
    return rect;
}

static void roundRect(CGContextRef context, CGRect rect,
                      CGFloat ovalWidth, CGFloat ovalHeight)
{
    CGFloat  fw = 0.0;
    CGFloat  fh = 0.0;
    
    assert(ovalWidth  >= 1.0);
    assert(ovalHeight >= 1.0);
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight); 
    
    fw = rect.size.width  / ovalWidth;
    fh = rect.size.height / ovalHeight; 
    
    CGContextMoveToPoint(context, fw, fh / 2.0);
    CGContextAddArcToPoint(context, fw, fh, fw / 2.0, fh, 1.0);
    CGContextAddArcToPoint(context, 0.0, fh, 0, fh / 2.0, 1.0);
    CGContextAddArcToPoint(context, 0.0, 0.0, fw / 2.0, 0, 1.0);
    CGContextAddArcToPoint(context, fw, 0.0, fw, fh / 2.0, 1.0); 
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}


@implementation UIView (drawing)


-(void)contextRestore:(CGContextRef)context
{
    CGContextRestoreGState(context);
}

-(CGContextRef)contextSave
{
    CGContextRef  ctxt = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctxt);
    
    return ctxt;
}

-(void)drawPoint:(CGPoint)point
{
    [self drawPoint:point color:nil];
}

-(void)drawPoint:(CGPoint)point color:(UIColor*)color
{
    CGRect  rect = CGRectMake(point.x, point.y, 1.0, 1.0);
    [self fillRect:rect color:color];
}

-(void)fillRect:(CGRect)rect
{
    [self fillRect:rect color:nil];
}

-(void)fillRect:(CGRect)rect color:(UIColor*)color
{
    CGContextRef  ctxt = [self contextSave];
    
    if (color)
    {
        CGContextSetFillColorWithColor(ctxt, [color CGColor]);
    }    
    
    UIRectFill(rect);
    [self contextRestore:ctxt];
}

-(void)fillRoundRect:(CGRect)rect
{
    [self fillRoundRect:rect color:nil];
}

-(void)fillRoundRect:(CGRect)rect color:(UIColor*)color
{
    CGContextRef  ctxt = [self contextSave];
    
    roundRect(ctxt, rect, kCornerSize, kCornerSize);
    
    if (color)
    {
        CGContextSetFillColorWithColor(ctxt, [color CGColor]);
    }    
    
    CGContextFillPath(ctxt);
    [self contextRestore:ctxt];
}

-(void)strokeRect:(CGRect)rect
{
    [self strokeRect:rect color:nil];
}

-(void)strokeRect:(CGRect)rect color:(UIColor*)color
{
    CGContextRef  ctxt = [self contextSave];
    
    if (color)
    {
        CGContextSetStrokeColorWithColor(ctxt, [color CGColor]);
    }    
    
    UIRectFrame(rect);
    [self contextRestore:ctxt];
}

-(void)strokeRoundRect:(CGRect)rect
{
    [self strokeRoundRect:rect color:nil];
}

-(void)strokeRoundRect:(CGRect)rect color:(UIColor*)color
{
    CGContextRef  ctxt = [self contextSave];
    
    rect = rectStrokeAdjust(rect);
    roundRect(ctxt, rect, kCornerSize, kCornerSize);
    
    if (color)
    {
        CGContextSetStrokeColorWithColor(ctxt, [color CGColor]);
    }    
    
    CGContextStrokePath(ctxt);
    [self contextRestore:ctxt];
}

@end





