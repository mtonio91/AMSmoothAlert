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


- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type;
- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type;
- (void) setCornerRadius:(float)cornerRadius;
-(void) setTitleText:(NSString*) string;
-(void) setMessageText:(NSString*) string;
- (void) show;
- (void) dismissAlertView;



@end
