//
//  NDStrechView.h
//  NDStrechView
//
//  Created by Nathan Day on 26/08/11.
//  Copyright 2011 Nathan Day. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDStrechView : UIView

@property(nonatomic,readonly)							NSSet		* hiddenViews;
@property(nonatomic,readonly)							NSSet		* visibleViews;
@property(nonatomic,assign,getter=isAllViewsHidden)		BOOL		allViewsHidden;
@property(nonatomic,assign,getter=isAllViewsVisible)	BOOL		allViewsVisible;
@property(assign)										NSUInteger	sa;

- (void)setHidden:(BOOL)flag view:(UIView *)view;
- (BOOL)isViewHidden:(UIView *)view;

- (void)setHidden:(BOOL)flag index:(NSUInteger)index;
- (BOOL)isViewIndexHidden:(NSUInteger)index;

- (void)setHidden:(BOOL)flag views:(UIView *)firstView, ...;
- (void)setHidden:(BOOL)flag indexes:(NSUInteger *)indexes count:(NSUInteger)count;
- (void)setHidden:(BOOL)flag viewSet:(NSSet *)set;

- (void)enumerateObjectsUsingBlock:(BOOL (^)(UIView * view, NSUInteger index, BOOL *stop))setViewHidden;

- (NSUInteger)indexOfView:(UIView *)view;

@end
