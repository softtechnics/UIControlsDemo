//
//  SOSlider.m
//  StatusOn
//
//  Created by Sergey Gavrilyuk on 6/2/11.
//  Copyright 2011 SoftTechnics. All rights reserved.
//

#import "SOSlider.h"
#import <QuartzCore/QuartzCore.h>

@implementation SOSlider

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark construction && deconstruction
////////////////////////////////////////////////////////////////////////////////////////////////////


-(void) commonInit
{
	UIImageView* background = [[UIImageView alloc] initWithImage:
							   [[UIImage imageNamed:@"slide_background.png"] stretchableImageWithLeftCapWidth:11 
																								 topCapHeight:16]];
	background.frame = self.bounds;
	background.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	[self addSubview:background];
	[background release];
	
	fKnobView = [[UIImageView alloc] initWithImage:
				 [[UIImage imageNamed:@"slide_knob.png"] stretchableImageWithLeftCapWidth:10 
																			 topCapHeight:16]];
	fKnobView.opaque = NO;
	fKnobLabel = [[UILabel alloc] init];
	fKnobLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
	fKnobLabel.textColor = [UIColor lightGrayColor];
	fKnobLabel.textAlignment = UITextAlignmentCenter;
	fKnobLabel.backgroundColor = [UIColor clearColor];
	fKnobLabel.frame = fKnobView.bounds;
	fKnobLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	
	[fKnobView addSubview: fKnobLabel];
	[self addSubview:fKnobView];
	
}

////////////////////////////////////////////////////////////////////////////////////////////////////
-(id) initWithStates:(NSArray*) states
{
	if((self = [super init])!= nil)
	{
		[self commonInit];
		[self setStates:states];
	}
	return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
-(id) initWithCoder:(NSCoder *)aDecoder
{
	if((self = [super initWithCoder:aDecoder])!= nil)
	{
		[self commonInit];
	}
	return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
-(void) setStates:(NSArray*) states
{
	NSMutableArray* arr = [[NSMutableArray alloc] init];
	
	for(NSString* stateStr in states)
	{
		UILabel* label = [[UILabel alloc] init];
		label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
		label.textColor = [UIColor whiteColor];
		label.textAlignment = UITextAlignmentCenter;
		label.backgroundColor = [UIColor clearColor];
		label.text = stateStr;
		
		[arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:
						stateStr, @"name",
						label, @"label",
						nil]];
		
		[self addSubview:label];
		[label release];
		
	}
	fCurrentState = 0;
	
	fKnobLabel.text = [states objectAtIndex:fCurrentState];
	[self setNeedsLayout];
	
	[fStates release];
	fStates = [[NSArray alloc] initWithArray:arr];
	[arr release];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
-(void) dealloc
{
	[fStates release];
	[fKnobView release];
	[fKnobLabel release];
	
	[super dealloc];
}
////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark layout
////////////////////////////////////////////////////////////////////////////////////////////////////
-(void) layoutSubviews
{
	[super layoutSubviews];
	
    if(![fStates count])
        return;
    
	CGFloat labelWidth = (self.frame.size.width-2) / (CGFloat)[fStates count];
	for(NSInteger i=0; i< [fStates count]; ++i)
	{
		NSDictionary* stateDict  = [fStates objectAtIndex:i];
		
		[(UILabel*)[stateDict objectForKey:@"label"] setFrame:CGRectMake(ceil(labelWidth*i), 0, 
                                                                         labelWidth, self.frame.size.height)];
	}
	
	fKnobView.frame = CGRectMake(1+ceil(fCurrentState*labelWidth), 1, labelWidth, self.frame.size.height-2);
	[self bringSubviewToFront:fKnobView];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark tracking
////////////////////////////////////////////////////////////////////////////////////////////////////

-(BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	return CGRectContainsPoint(fKnobView.frame, [touch locationInView:self]);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
-(BOOL) continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGFloat offset = [touch locationInView:self].x - [touch previousLocationInView:self].x;
	CGFloat labelWidth = (self.frame.size.width-2)/[fStates count];
	
	fKnobView.frame = CGRectMake(MIN(MAX(1,ceil(fKnobView.frame.origin.x + offset)), ceil(self.frame.size.width-1-labelWidth)), 
			   fKnobView.frame.origin.y, 
			   fKnobView.frame.size.width, fKnobView.frame.size.height);

	
	return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
-(void) endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	
	CGFloat labelWidth = (self.frame.size.width-2)/(CGFloat)[fStates count];
	NSInteger oldStateIndex = fCurrentState;
	
	fCurrentState = MIN(round(fKnobView.frame.origin.x/labelWidth), [fStates count]-1);
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	fKnobView.frame = CGRectMake(1+ceil(fCurrentState*labelWidth), 1, labelWidth, self.frame.size.width-2);
	[UIView commitAnimations];
	
	fKnobLabel.text = [(NSDictionary*)[fStates objectAtIndex:fCurrentState] objectForKey:@"name"];
	CATransition* transiotion = [CATransition animation];
	transiotion.type = kCATransitionFade;
	[fKnobLabel.layer addAnimation:transiotion forKey:nil];
	
	if(oldStateIndex != fCurrentState)
		[self sendActionsForControlEvents:UIControlEventValueChanged];
}
////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark properties
////////////////////////////////////////////////////////////////////////////////////////////////////

-(NSString *) value
{
	return (NSString*)[(NSDictionary*)[fStates objectAtIndex:fCurrentState] objectForKey:@"name"];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
-(NSInteger) valueIndex
{
	return fCurrentState;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
@end
