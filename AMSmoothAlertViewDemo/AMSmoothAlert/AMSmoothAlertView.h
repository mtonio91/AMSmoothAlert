//
//  AMSmoothAlertView.h
//  AMSmoothAlertViewDemo
//
//  Created by AMarliac on 2014-04-24.
//  Copyright (c) 2014 AMarliac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>
#import "AMBouncingView.h"
#import "AMSmoothAlertConstants.h"

@protocol AMSmoothAlertViewDelegate;

@interface AMSmoothAlertView : UIView


@property (nonatomic, assign) float cornerRadius;
@property (nonatomic, assign) bool isDisplayed;
@property (nonatomic, assign) AnimationType animationType;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * textLabel;
@property (nonatomic, strong) UIButton *defaultButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, weak) id<AMSmoothAlertViewDelegate> delegate;


- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type;
- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color;
- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type;
- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color;
- (void) setCornerRadius:(float)cornerRadius;
- (void) setTitleText:(NSString*) string;
- (void) setMessageText:(NSString*) string;
- (void) show;
- (void) dismissAlertView;
- (void) handleButtonTouched:(id) sender;


@end

@protocol AMSmoothAlertViewDelegate <NSObject>

-(void)alertView:(AMSmoothAlertView *)alertView didDismissWithButton:(UIButton *)button;

@end