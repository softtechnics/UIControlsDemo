//
//  SOSlider.h
//  StatusOn
//
//  Created by Sergey Gavrilyuk on 6/2/11.
//  Copyright 2011 SoftTechnics. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SOSlider : UIControl
{
	NSArray* fStates;
	UIView* fKnobView;
	NSInteger fCurrentState;
	UILabel* fKnobLabel;
}

-(id) initWithStates:(NSArray*) states;
-(void) setStates:(NSArray*) states;

@property (nonatomic, readonly) NSString* value;
@property (nonatomic, readonly) NSInteger valueIndex;

@end
