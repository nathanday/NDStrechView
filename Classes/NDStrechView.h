/*
	NDStrechView.h

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

#import <UIKit/UIKit.h>

@interface NDStrechView : UIView

@property(nonatomic,readonly)							NSSet		* hiddenViews;
@property(nonatomic,readonly)							NSSet		* visibleViews;
@property(nonatomic,assign,getter=isAllViewsHidden)		BOOL		allViewsHidden;
@property(nonatomic,assign,getter=isAllViewsVisible)	BOOL		allViewsVisible;
@property(assign)										NSUInteger	resizeSuperViewDepth;

- (void)setHidden:(BOOL)flag view:(UIView *)view;
- (BOOL)isViewHidden:(UIView *)view;

- (void)setHidden:(BOOL)flag views:(UIView *)firstView, ...;
- (void)setHidden:(BOOL)flag viewSet:(NSSet *)set;

- (void)enumerateObjectsUsingBlock:(BOOL (^)(UIView * view, NSUInteger index, BOOL *stop))setViewHidden;

@end
