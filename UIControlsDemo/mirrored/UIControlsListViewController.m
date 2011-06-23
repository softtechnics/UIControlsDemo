//
//  UIControlsListViewController.m
//  UIControlDemo
//
//  Created by Sergey Gavrilyuk on 6/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIControlsListViewController.h"
#import "STKnobViewController.h"
#import "STSliderViewController.h"

@implementation UIControlsListViewController


- (void)dealloc
{
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    switch (indexPath.row)
    {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"Handle_0127.png"];
            cell.textLabel.text = @"Knob";
            break;
        case 1:
            cell.textLabel.text = @"Slider";
            break;
        default:
            break;
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        STKnobViewController* viewCtrl = [[STKnobViewController alloc] 
                                          initWithNibName:@"STKnobViewController" bundle:nil];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        [viewCtrl release];
        
    }
    else if(indexPath.row == 1)
    {
        STSliderViewController* viewCtrl = [[STSliderViewController alloc] initWithNibName:@"STSliderViewController" 
                                                                                    bundle:nil];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        [viewCtrl release];
    }
}

@end
