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
	CGRect		viewFrames[8];
}

- (BOOL)checkViewPositions;
- (void)recordViewPositions;

@property(readonly)		CGRect * viewFrames;
@property(readonly)		NSUInteger viewFramesCount;

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
				toggleButtons;

#pragma mark - manually implemented properties

- (CGRect *)viewFrames { return viewFrames; }
- (NSUInteger)viewFramesCount { return sizeof(viewFrames)/sizeof(*viewFrames); }


#pragma mark - View lifecycle

- (void)viewDidUnload
{
    titleLabel = nil;
    label1 = nil;
    footerLabel = nil;
    toggleButtons = nil;
	scretchView = nil;
    [super viewDidUnload];
}

- (void)viewDidLoad
{
	[self recordViewPositions];
    [super viewDidLoad];
}

- (void)dealloc
{
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


- (IBAction)toggleHiddenAction:(UIButton *)aSender
{
	UILabel		* theView = [self labelForIndex: aSender.tag];
	NSParameterAssert( theView != nil );
	[self.scretchView setHidden:!theView.isHidden view:theView];
	aSender.selected = theView.isHidden;
	
	if( self.scretchView.isAllViewsVisible )
	{
//		NSParameterAssert([self checkViewPositions]);
	}
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

@end
