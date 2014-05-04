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

- (id) initWithTitle:(NSString*) title andText:(NSString*) text forAlertType:(AlertType) type;
- (void) setCornerRadius:(float)cornerRadius;
- (void) show;
- (void) dismissAlertView;



@end
