/*
	NDStrechView.m

	Created by Nathan Day on 26.08.11 under a MIT-style license.
	Copyright (c) 2011 Nathan Day

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
 */

#import "NDStrechView.h"

static inline CGFloat CGDiff( CGFloat a, CGFloat b ) { return a > b ? (a -  b) : (b - a); }

@interface NDStrechView ()
{
	NSMutableData		* marginsForViewsData;
}
- (NSUInteger)insertIndexForSubview:(UIView *)veiw;
- (NSUInteger)indexForSubview:(UIView *)veiw;
- (CGFloat)heightAfterUpdateViewPosition;
- (UIView *)previousVisibleViewForViewAt:(NSUInteger)index;
- (void)resizeFrameAndSuperViewForBoundsHeight:(CGFloat)height;

@property(readonly)				NSMutableData	* marginsForViewsData;
@property(readonly)				CGFloat			* marginsForViews;

@end

@implementation NDStrechView

@synthesize			resizeSuperViewDepth;

#pragma mark - manually implemented propeties

- (NSMutableData *)marginsForViewsData
{
	NSUInteger		theBytesCount = (self.subviews.count + 1) * sizeof(CGFloat);
	if( marginsForViewsData == nil )
		marginsForViewsData = [[NSMutableData alloc] initWithLength:theBytesCount];
	else if (marginsForViewsData.length < theBytesCount)
		marginsForViewsData.length = theBytesCount;
	return marginsForViewsData;	
}

- (CGFloat*)marginsForViews { return (CGFloat*)self.marginsForViewsData.mutableBytes; }

- (NSSet *)hiddenViews
{
	NSMutableSet	* theSet = [NSMutableSet set];
	for( UIView * theView in self.subviews )
	{
		if( theView.isHidden )
			[theSet addObject:theView];
	}
	return theSet;
}

- (NSSet *)visibleViews
{
	NSMutableSet	* theSet = [NSMutableSet set];
	for( UIView * theView in self.subviews )
	{
		if( !theView.isHidden )
			[theSet addObject:theView];
	}
	return theSet;
}

- (void)setAllViewsHidden:(BOOL)aFlag
{
	for( UIView * theView in self.subviews )
		theView.hidden = aFlag;

	[self resizeFrameAndSuperViewForBoundsHeight:[self heightAfterUpdateViewPosition]];
}

- (BOOL)isAllViewsHidden
{
	for( UIView * theView in self.subviews )
	{
		if( !theView.isHidden )
			return false;
	}
	return true;
}

- (void)setAllViewsVisible:(BOOL)aFlag { [self setAllViewsHidden:!aFlag]; }

- (BOOL)isAllViewsVisible
{
	for( UIView * theView in self.subviews )
	{
		if( theView.isHidden )
			return false;
	}
	return true;
}

#pragma mark - creation destruction

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) != nil )
	{
        // Initialization code here.
    }
    
    return self;
}

#pragma mark - set views hidden

- (void)setHidden:(BOOL)aFlag view:(UIView *)aView
{
	aView.hidden = aFlag;
	[self resizeFrameAndSuperViewForBoundsHeight:[self heightAfterUpdateViewPosition]];
}

- (BOOL)isViewHidden:(UIView *)aView { return aView.superview == self && aView.hidden; }

- (void)setHidden:(BOOL)aFlag views:(UIView *)aFirstView, ...
{
    va_list			theVAList;
	UIView			* theView = nil;
    va_start(theVAList, aFirstView);

    aFirstView.hidden = aFlag;
	while( (theView = va_arg(theVAList, UIView*)) != nil )
	{
		NSParameterAssert( theView.superview == self );
		theView.hidden = aFlag;
	}

	[self resizeFrameAndSuperViewForBoundsHeight:[self heightAfterUpdateViewPosition]];
    va_end(theVAList);
}

- (void)setHidden:(BOOL)aFlag viewSet:(NSSet *)aSet
{
	for( UIView * theView in aSet )
	{
		NSParameterAssert( theView.superview == self );
		theView.hidden = aFlag;
	}

	[self resizeFrameAndSuperViewForBoundsHeight:[self heightAfterUpdateViewPosition]];
}

- (void)enumerateObjectsUsingBlock:(BOOL (^)(UIView * aView, NSUInteger index, BOOL *stop))setViewHidden
{
	BOOL		theStop = NO;
	for( NSUInteger i = 0, c = self.subviews.count; i < c && theStop == NO; i++ )
	{
		UIView		* theView = [self.subviews objectAtIndex:i];

		BOOL		theHide = setViewHidden( theView, i, &theStop);
		if( !theStop && theView.isHidden != theHide )
			theView.hidden = theHide;
	}
	[self resizeFrameAndSuperViewForBoundsHeight:[self heightAfterUpdateViewPosition]];
}

#pragma mark - UIView methods

- (void)insertSubview:(UIView *)aView atIndex:(NSInteger)index
{
	
}

- (void)exchangeSubviewAtIndex:(NSInteger)anIndex1 withSubviewAtIndex:(NSInteger)anIndex2
{
	
}

- (void)addSubview:(UIView *)aView
{
	NSUInteger		theIndex = [self insertIndexForSubview:aView],
					theCount = self.subviews.count;
	[super insertSubview:aView atIndex:theIndex];
	
	if( theIndex == 0 )
		self.marginsForViews[0] = CGRectGetMinY(aView.frame) - CGRectGetMinY(self.bounds);
	else
		self.marginsForViews[theIndex] = CGRectGetMinY(aView.frame) - CGRectGetMaxY([[self.subviews objectAtIndex:theIndex-1] frame]);


	if( theIndex == theCount )
		self.marginsForViews[theIndex+1] = CGRectGetMaxY(self.bounds) - CGRectGetMaxY(aView.frame);
	else
		self.marginsForViews[theIndex+1] = CGRectGetMinY([[self.subviews objectAtIndex:theIndex+1] frame]) - CGRectGetMaxY(aView.frame);
}

- (void)insertSubview:(UIView *)aView belowSubview:(UIView *)siblingSubview
{
	
}

- (void)insertSubview:(UIView *)aView aboveSubview:(UIView *)siblingSubview
{
	
}

- (void)bringSubviewToFront:(UIView *)aView
{
	
}

- (void)sendSubviewToBack:(UIView *)aView
{
	
}

- (void)didMoveToSuperview
{
	[super didMoveToSuperview];
}

#pragma mark - private methods

- (NSUInteger)insertIndexForSubview:(UIView *)aSubjectView
{
	NSArray			* theSubViews = self.subviews;
	CGFloat			theSubjectMid = CGRectGetMidY(aSubjectView.frame);
	NSUInteger		theResult = NSNotFound;
	NSUInteger		theCount = theSubViews.count;

	/*
		most of the time it will be just and append to the end
	 */
	if( theCount == 0 || CGRectGetMidY([theSubViews.lastObject frame]) < theSubjectMid )
		theResult = self.subviews.count;
		
	for( NSUInteger theLower = 0, theUpper = theCount; theResult == NSNotFound; theResult = (theUpper+theLower)>>1 )
	{
		if( theLower + 1 >= theUpper )		// down to between two possibilities
		{
			CGFloat			theMid = CGRectGetMidY([[theSubViews objectAtIndex:theLower] frame]);
			if( theSubjectMid > theMid )
				theResult = theUpper;
			else
				theResult = theLower;
		}
		else
		{
			CGFloat			theMid = CGRectGetMidY([[theSubViews objectAtIndex:theResult] frame]);
			if( theSubjectMid < theMid )
				theUpper = theMid;
			else
				theLower = theMid;
		}
	}
	return theResult;
}

- (NSUInteger)indexForSubview:(UIView *)aView
{
	NSUInteger		theIndex = 0;
	for( UIView * theView in self.subviews )
	{
		if( theView == aView )
			return theIndex;
		theIndex++;
	}
	return NSNotFound;
}

- (CGFloat)heightAfterUpdateViewPosition
{
	__block CGFloat		thePreviousBottom = CGRectGetMinY(self.bounds);
	__block NSUInteger	theLastIndex = 0;
	[self.subviews enumerateObjectsUsingBlock:^(id anObject, NSUInteger anIndex, BOOL * aStop )
	{
		UIView					* theView = anObject;
		UIViewAutoresizing		theViewAutoresizing = (theView.autoresizingMask&(UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin));
		if( !theView.isHidden )
		{
			CGRect		theFrame = theView.frame;
				CGFloat		theTopMarginForView = self.marginsForViews[anIndex];
				theFrame.origin.y = thePreviousBottom + theTopMarginForView;

			theView.frame = theFrame;
			thePreviousBottom = CGRectGetMaxY(theFrame);
			theLastIndex = anIndex;
		}
		
		theView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|theViewAutoresizing;
	}];
	return thePreviousBottom + self.marginsForViews[theLastIndex];
}

- (UIView *)previousVisibleViewForViewAt:(NSUInteger)anIndex
{
	UIView			* theResult = nil;
	NSArray			* theSubviews = self.subviews;
	for( NSUInteger i = anIndex; i > 0 && theResult == nil; i-- )
	{
		UIView		* theView = [theSubviews objectAtIndex:i-1];
		if( !theView.isHidden )
			theResult = theView;
	}
	return theResult;
}

- (void)resizeFrameAndSuperViewForBoundsHeight:(CGFloat)aHeight
{
	
	CGRect			theBounds = self.bounds;
	UIView			* theSuperView = self.superview;

	CGFloat			theDiff = [self convertRect:theBounds toView:theSuperView].size.height - aHeight;
	UIView			* theView = self;

	while( theView != nil && (theView.autoresizingMask & (UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin)) == 0 )
		theView = theView.superview;

	CGRect	theFrame = theView.frame;
	theFrame.size.height -= theDiff;
	if( (theView.autoresizingMask & UIViewAutoresizingFlexibleTopMargin) != 0 )
	{
		if( (theView.autoresizingMask & UIViewAutoresizingFlexibleBottomMargin) != 0 )
			theFrame.origin.y += theDiff/2.0;
		else
			theFrame.origin.y += theDiff;
	}
	theView.frame = theFrame;
}


@end
