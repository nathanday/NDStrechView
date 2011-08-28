/*
	NDStrechViewAppDelegate.h
	NDStrechView

	Created by Nathan Day on 26/08/11.
	Copyright 2011 Nathan Day. All rights reserved.
 */

#import <UIKit/UIKit.h>

@class NDStrechViewViewController;

@interface NDStrechViewAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet NDStrechViewViewController *viewController;

@end
