//
//  NDStrechViewViewController.h
//  NDStrechView
//
//  Created by Nathan Day on 26/08/11.
//  Copyright 2011 Nathan Day. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NDStrechView;

@interface NDStrechViewViewController : UIViewController
{
@private
	IBOutlet NDStrechView	* scretchView;
	IBOutlet UILabel		* titleLabel;
	IBOutlet UILabel		* label1;
	IBOutlet UILabel		* label2;
	IBOutlet UILabel		* label3;
	IBOutlet UILabel		* label4;
	IBOutlet UILabel		* label5;
	IBOutlet UILabel		* label6;
	IBOutlet UILabel		* footerLabel;

	IBOutletCollection(UIButton) NSArray *toggleButtons;
	IBOutlet UISwitch *bulkToggleButton;
}

@property(readonly)		NDStrechView	* scretchView;
@property(readonly)		UILabel			* titleLabel;
@property(readonly)		UILabel			* label1;
@property(readonly)		UILabel			* label2;
@property(readonly)		UILabel			* label3;
@property(readonly)		UILabel			* label4;
@property(readonly)		UILabel			* label5;
@property(readonly)		UILabel			* label6;
@property(readonly)		UILabel			* footerLabel;
@property(readonly)		NSArray			* toggleButtons; 

@property(assign,nonatomic,getter=isBulkChangeOn)		BOOL	bulkChangeOn;

- (IBAction)bulkChangeAction:(UISwitch *)sender;
- (IBAction)toggleHiddenAction:(UIButton *)sender;
- (IBAction)hideAllAction:(UIButton *)sender;
- (IBAction)showAllAction:(UIButton *)sender;

@end
