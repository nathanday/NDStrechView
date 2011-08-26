//
//  NDStrechViewViewController.m
//  NDStrechView
//
//  Created by Nathan Day on 26/08/11.
//  Copyright 2011 Nathan Day. All rights reserved.
//

#import "NDStrechViewViewController.h"

@implementation NDStrechViewViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [titleLabel release];
    titleLabel = nil;
    [label1 release];
    label1 = nil;
    [footerLable release];
    footerLable = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [titleLabel release];
    [label1 release];
    [footerLable release];
    [super dealloc];
}
@end
