//
//  STKnobControl.m
//  mirrored
//
//  Created by Sergey Gavrilyuk on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "STKnobControl.h"

@interface STKnobControl()

-(void) updateValuePresentation;
-(void) animateSettingValue:(NSNumber*)number;
@end


@implementation STKnobControl
@synthesize value = fCurrentValue;


////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark construction && deconstruction
////////////////////////////////////////////////////////////////////////////////////////////////////

-(void) commonInit
{
    UIImageView* shadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Handle_Shadow.png"]];
    [self addSubview:shadowView];
    shadowView.frame = CGRectOffset(shadowView.frame, -35, -30);
    [shadowView release];

    fKnobView = [[UIImageView alloc] initWithFrame:self.bounds];
    fKnobView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self addSubview:fKnobView];
    fCurrentValue = 0;
    [self updateValuePresentation];    
}

-(id)init
{
    if((self = [super init]) != nil)
    {
        [self commonInit];
    }
    return  self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]) != nil)
    {
        [self commonInit];
    }
    return  self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark properties
////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setValue:(NSInteger)value
{
    [self setValue:value animated:NO];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
-(void) setValue:(NSInteger)value animated:(BOOL)animated
{
    if(!animated)
    {
        fCurrentValue = value;   
        [self updateValuePresentation];
    }
    else
    {
        [self animateSettingValue:[NSNumber numberWithInt:value]];
    }
   
}

-(void) animateSettingValue:(NSNumber*)number;
{
    NSInteger neededValue = [number intValue];
    if(fCurrentValue == neededValue)
        return;
    
    if(fCurrentValue< neededValue)
        fCurrentValue++;
    else  
        fCurrentValue--;
    [self updateValuePresentation];
    [self performSelector:@selector(animateSettingValue:) 
               withObject:number afterDelay:.01];
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
-(void) updateValuePresentation
{
    fKnobView.image = [UIImage imageNamed:
                       [NSString stringWithFormat:@"Handle_%04d.png", 127-fCurrentValue]];
    
}


////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark touches
////////////////////////////////////////////////////////////////////////////////////////////////////

-(BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    
	if(event.type != UIEventTypeTouches)
		return NO;
	
	CGPoint point = [touch locationInView:self.superview];
	if(CGRectContainsPoint(self.frame, point))
	{
		return YES;
	}
	
	return NO;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL) continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	if(event.type == UIEventTypeTouches)
	{
		CGPoint currentPoint =  [touch locationInView:self];
		CGFloat currentX = (currentPoint.x - fKnobView.center.x);
		CGFloat currentY = -(currentPoint.y - fKnobView.center.y);
		
		CGFloat currentR = sqrt(currentX*currentX + currentY*currentY);
		CGFloat currentAngle = asin(currentY/currentR);
        
		if(currentX<0 && currentY>=0)
			currentAngle = M_PI - currentAngle;
		else if(currentX<0 && currentY<0)
			currentAngle = M_PI-currentAngle;
		else if(currentX>=0 && currentY<0)
			currentAngle = 2*M_PI + currentAngle;
		
        
		CGPoint prevPoint = [touch previousLocationInView:self];
		CGFloat prevX = (prevPoint.x - fKnobView.center.x);
		CGFloat prevY = -(prevPoint.y - fKnobView.center.y);
		
		CGFloat prevR = sqrt(prevX*prevX + prevY*prevY);
		
		CGFloat prevAngle = asin(prevY/prevR);
		if(prevX<0 && prevY>=0)
			prevAngle = M_PI - prevAngle;
		else if(prevX<0 && prevY<0)
			prevAngle = M_PI-prevAngle;
		else if(prevX>=0 && prevY<0)
			prevAngle = 2*M_PI + prevAngle;
		
		
		CGFloat angleDistance = (prevAngle-currentAngle);
		if(prevAngle>=0 && prevAngle < M_PI_2 && currentAngle >=3*M_PI/2 && currentAngle <=2*M_PI)
			angleDistance += 2*M_PI;
        
		if(currentAngle>=0 && currentAngle < M_PI_2 && prevAngle >=3*M_PI/2 && prevAngle <=2*M_PI)
			angleDistance -= 2*M_PI;
		
		
		NSInteger newValue = ceil((fCurrentAbsoluteAngle + angleDistance + 5*M_PI/6)*(/*maxValue*/127-/*minValue*/0)/(5*M_PI/3));
		
		if(newValue >= /*minValue*/0 && newValue <= /*maxValue*/127)
		{
			fCurrentValue = newValue;
			
			fCurrentAbsoluteAngle += angleDistance;
			
			[self updateValuePresentation];
			
			[self sendActionsForControlEvents:UIControlEventValueChanged];
            
			return YES;
		}
        
	}
	
	return NO;
}

@end
