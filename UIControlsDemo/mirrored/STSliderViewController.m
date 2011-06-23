//
//  STSliderViewController.m
//  UIControlDemo
//
//  Created by Sergey Gavrilyuk on 6/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "STSliderViewController.h"


@implementation STSliderViewController
@synthesize  slider1, slider2;


- (void)dealloc
{
    self.slider1 = nil;
    self.slider2 = nil;
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.slider1 setStates:[NSArray arrayWithObjects:@"State1",@"State2", nil]];
    [self.slider2 setStates:[NSArray arrayWithObjects:@"View1",@"View2", @"View3", nil]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.slider1 = nil;
    self.slider2 = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
