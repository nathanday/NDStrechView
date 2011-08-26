//
//  NDStrechView.m
//  NDStrechView
//
//  Created by Nathan Day on 26/08/11.
//  Copyright 2011 Nathan Day. All rights reserved.
//

#import "NDStrechView.h"

@interface NDStrechView ()
{
}

- (NSUInteger)indexForView:(UIView *)view;
- (NSUInteger)indexForFrame:(CGRect)rect;

@end

@implementation NDStrechView

@synthesize			resizeSuperViewaSepth;

#pragma mark - manually implemented propeties

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

- (void)isAllViewsVisible:(BOOL)aFlag
{
	
}

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
	
}

- (BOOL)isViewHidden:(UIView *)aView
{
	
}

- (void)setHidden:(BOOL)aFlag index:(NSUInteger)anIndex
{
	
}

- (BOOL)isViewIndexHidden:(NSUInteger)anIndex
{
	
}

- (void)setHidden:(BOOL)aFlag views:(UIView *)firstView, ...
{
	
}

- (void)setHidden:(BOOL)aFlag indexes:(NSUInteger *)anIndexes count:(NSUInteger)count{
	
}

- (void)setHidden:(BOOL)aFlag viewSet:(NSSet *)aSet
{
	
}

- (void)enumerateObjectsUsingBlock:(BOOL (^)(UIView * aView, BOOL hidden, BOOL *stop))setViewHidden
{

}

- (NSUInteger)indexOfView:(UIView *)aView { return [self.subviews indexOfObjectIdenticalTo:aView]; }

#pragma mark - UIViw methods

- (void)addSubview:(UIView *)aView { [self insertSubview:aView atIndex:[self indexOfView:aView]; }

- (void)bringSubviewToFront:(UIView *)aView { [self exchangeSubviewAtIndex:[self indexOfView:aView] withSubviewAtIndex:0]; }

- (void)sendSubviewToBack:(UIView *)aView { [self exchangeSubviewAtIndex:[self indexOfView:aView] withSubviewAtIndex:self.subviews.count-1]; }
									  
- (CGSize)sizeThatFits:(CGSize)aSize
{
	
}

- (void)willRemoveSubview:(UIView *)aSubview
{
}

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
	
}

- (void)insertSubview:(UIView *)aView aboveSubview:(UIView *)siblingSubview { [self insertSubview:aView atIndex:[self indexOfView:siblingSubview]]; }
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview { [self insertSubview:aView atIndex:[self indexOfView:siblingSubview]+1]; 

- (void)exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2
{
	
}

- (void)didMoveToSuperview
{
	
}

#pragma mark - private methods

- (NSUInteger)indexForView:(UIView *)aView { return [self indexForFrame:aView.frame]; }
- (NSUInteger)indexForFrame:(CGRect)aRect
{
	NSArray		* theSubViews = self.subviews;
	CGFloat		theInMidY = CGRectGetMaxY(aRect);
	NSUInteger	l = 0,
				u = theSubViews.count - 1;

	while( l < u )
	{
		NSUInteger	m = (l + u) >> 1;
		CGFloat		theMidY = CGRectGetMaxY([[theSubViews objectAtIndex:m] frame]);
		if( theInMidY > theMidY )
			l = m;
		else if( theInMidY < theMidY )
			u = m;
	}
	return l;
}


@end
