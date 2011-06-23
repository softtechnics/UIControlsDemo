//
//  mirroredViewController.h
//  mirrored
//
//  Created by Sergey Gavrilyuk on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STKnobControl.h"
@interface STKnobViewController : UIViewController <UITextFieldDelegate>
{
    
}

@property (nonatomic, retain) IBOutlet STKnobControl* knobControl;
@property (nonatomic, retain) IBOutlet UITextField* valueTextField;

-(IBAction) knobValueChanged:(id)sender;
@end
