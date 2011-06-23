//
//  mirroredViewController.m
//  mirrored
//
//  Created by Sergey Gavrilyuk on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "STKnobViewController.h"

@implementation STKnobViewController
@synthesize knobControl, valueTextField;

- (void)dealloc
{
    self.valueTextField = nil;
    self.knobControl = nil;

    [super dealloc];
}



#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    self.valueTextField = nil;
    self.knobControl = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction) knobValueChanged:(id)sender
{
    self.valueTextField.text = [NSString stringWithFormat:@"%d", 
                            [(STKnobControl*)sender value] ];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger value = [textField.text intValue];
    [self.knobControl setValue:value animated:YES];
    [textField resignFirstResponder];
    return  NO;
}
@end
