//
//  AMSmoothAlertView.h
//  AMSmoothAlertViewDemo
//
//  Created by AMarliac on 2014-04-24.
//  Contributor: Everest Liu
//  Copyright (c) 2014 AMarliac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>
#import "AMBouncingView.h"
#import "AMSmoothAlertConstants.h"

@class AMSmoothAlertView;

typedef void (^dismissAlertWithButton)(AMSmoothAlertView *, UIButton *);

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
@property (nonatomic, copy) dismissAlertWithButton completionBlock;


- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type;
- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color;
- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type;
- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color;

// init with completion block

- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type withCompletionHandler:(dismissAlertWithButton) completionHandler;
- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color withCompletionHandler:(dismissAlertWithButton) completionHandler;
- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type withCompletionHandler:(dismissAlertWithButton) completionHandler;
- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color withCompletionHandler:(dismissAlertWithButton) completionHandler;

- (void) setCornerRadius:(float)cornerRadius;
- (void) setTitleText:(NSString*) string;
- (void) setMessageText:(NSString*) string;
- (void) show;
- (void) dismissAlertView;
- (void) handleButtonTouched:(id) sender;


@end

@protocol AMSmoothAlertViewDelegate <NSObject>

@optional
-(void) alertView:(AMSmoothAlertView *)alertView didDismissWithButton:(UIButton *)button;
-(void) alertViewWillShow:(AMSmoothAlertView *)alertView;
-(void) alertViewDidShow:(AMSmoothAlertView *)alertView;
-(void) alertViewWillDismiss:(AMSmoothAlertView *)alertView;
-(void) alertViewDidDismiss:(AMSmoothAlertView *)alertView;

@end