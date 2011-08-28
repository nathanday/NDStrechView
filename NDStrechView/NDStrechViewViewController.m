//
//  NDStrechViewViewController.m
//  NDStrechView
//
//  Created by Nathan Day on 26/08/11.
//  Copyright 2011 Nathan Day. All rights reserved.
//

#import "NDStrechViewViewController.h"
#import "NDStrechView.h"

@interface NDStrechViewViewController ()
{
	CGRect			viewFrames[8];
	BOOL			bulkChangeOn;
	NSMutableSet	* hideSet,
					* visibleSet;
}

- (BOOL)checkViewPositions;
- (void)recordViewPositions;

- (void)clearBulkSets;

@property(readonly)		CGRect			* viewFrames;
@property(readonly)		NSUInteger		viewFramesCount;
@property(readonly)		NSMutableSet	* hideSet;
@property(readonly)		NSMutableSet	* visibleSet;

@end

@implementation NDStrechViewViewController

@synthesize		scretchView,
				titleLabel,
				label1,
				label2,
				label3,
				label4,
				label5,
				label6,
				footerLabel,
				toggleButtons,
				bulkChangeOn;

#pragma mark - manually implemented properties

- (CGRect *)viewFrames { return viewFrames; }
- (NSUInteger)viewFramesCount { return sizeof(viewFrames)/sizeof(*viewFrames); }

- (NSMutableSet	*)hideSet
{
	if( hideSet == nil )
		hideSet = [[NSMutableSet alloc] init];
	return hideSet;
}

- (NSMutableSet	*)visibleSet
{
	if( visibleSet == nil )
		visibleSet = [[NSMutableSet alloc] init];
	return visibleSet;
}

- (void)setBulkChangeOn:(BOOL)aFlag
{
	if( aFlag == NO )
	{
		[self.scretchView setHidden:YES viewSet:self.hideSet];
		[self.scretchView setHidden:NO viewSet:self.visibleSet];
		[self clearBulkSets];
	}

	bulkChangeOn = aFlag;
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    titleLabel = nil;
    label1 = nil;
    footerLabel = nil;
    toggleButtons = nil;
	scretchView = nil;
	[hideSet release], hideSet = nil;
	[visibleSet release], visibleSet = nil;
	[bulkToggleButton release];
	bulkToggleButton = nil;
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self recordViewPositions];
}

- (void)dealloc
{
	[hideSet release];
	[visibleSet release];

	[bulkToggleButton release];
    [super dealloc];
}

- (UILabel *)labelForIndex:(NSUInteger)anIndex
{
	switch( anIndex )
	{
	case 0: return self.titleLabel;
	case 1: return self.label1;
	case 2: return self.label2;
	case 3: return self.label3;
	case 4: return self.label4;
	case 5: return self.label5;
	case 6: return self.label6;
	case 7: return self.footerLabel;
	default:
		NSAssert( NO, @"Bad tag %d",anIndex );
	}
	return nil;
}


- (IBAction)bulkChangeAction:(UISwitch *)aSender { self.bulkChangeOn = aSender.isOn; }

- (IBAction)toggleHiddenAction:(UIButton *)aSender
{
	UILabel		* theView = [self labelForIndex:aSender.tag];
	NSParameterAssert( theView != nil );

	if( self.isBulkChangeOn )
	{
		if( theView.isHidden )
			[self.visibleSet addObject:theView];
		else
			[self.hideSet addObject:theView];
		aSender.selected = !theView.isHidden;
	}
	else
	{
		[self.scretchView setHidden:!theView.isHidden view:theView];
		aSender.selected = theView.isHidden;
		
		if( self.scretchView.isAllViewsVisible )
			NSParameterAssert([self checkViewPositions]);
	}
}

- (IBAction)hideAllAction:(UIButton *)sender
{
	self.scretchView.allViewsHidden = YES;
	for( UIButton * theButton in self.toggleButtons )
		theButton.selected = YES;
}

- (IBAction)showAllAction:(UIButton *)sender
{
	self.scretchView.allViewsVisible = YES;
	for( UIButton * theButton in self.toggleButtons )
		theButton.selected = NO;
}

#pragma mark - Private Methods

- (BOOL)checkViewPositions
{
	BOOL	theResult = YES;
	for( NSInteger i = 0, c = self.viewFramesCount; i < c; i++ )
	{
		CGRect		theFrame = [self labelForIndex:i].frame;
		BOOL	theCompareResult = CGRectEqualToRect( self.viewFrames[i], theFrame );
		if( theResult )
			theResult = theCompareResult;
		if( !theCompareResult )
			fprintf( stderr, "Label %u was {{%3.0f,%3.0f},{%3.0f,%3.0f}}\n     is now {{%3.0f,%3.0f},{%3.0f,%3.0f}}\n", i,
					self.viewFrames[i].origin.x, self.viewFrames[i].origin.y, self.viewFrames[i].size.width, self.viewFrames[i].size.height,
					theFrame.origin.x, theFrame.origin.y, theFrame.size.width, theFrame.size.height );
	}
	return theResult;
}

- (void)recordViewPositions
{
	for( NSInteger i = 0, c = self.viewFramesCount; i < c; i++ )
		viewFrames[i] = [self labelForIndex:i].frame;
}

- (void)clearBulkSets
{
	[hideSet release], hideSet = nil;
	[visibleSet release], visibleSet = nil;
}

@end
