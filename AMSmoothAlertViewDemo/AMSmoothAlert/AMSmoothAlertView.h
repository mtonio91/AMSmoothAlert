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

#pragma mark - Drop Alert
- (id)initDropAlertWithTitle:(NSString*)title
                     andText:(NSString*)text
                forAlertType:(AlertType)type
                    andColor:(UIColor*)color
     withDefaultButtonAction:(void(^)(void))defaultButtonAction
      withCancelButtonAction:(void(^)(void))cancelButtonAction;

- (void)setCornerRadius:(float)cornerRadius;
- (void)setTitleText:(NSString*)string;
- (void)setMessageText:(NSString*)string;
- (void)show;
- (void)dismissAlertView;


@end

@protocol AMSmoothAlertViewDelegate <NSObject>

@optional
-(void)alertViewWillShow:(AMSmoothAlertView *)alertView;
-(void)alertViewDidShow:(AMSmoothAlertView *)alertView;
-(void)alertViewWillDismiss:(AMSmoothAlertView *)alertView;
-(void)alertViewDidDismiss:(AMSmoothAlertView *)alertView;
@end