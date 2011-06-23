//
//  STKnobControl.h
//  mirrored
//
//  Created by Sergey Gavrilyuk on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STKnobControl : UIControl 
{
    UIImageView* fKnobView;
    NSInteger fCurrentValue;
    CGFloat fCurrentAbsoluteAngle;
}


@property (nonatomic, assign) NSInteger value;
-(void) setValue:(NSInteger)value animated:(BOOL)animated;
@end
